import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/services/bt_devices.bloc.dart';
import 'package:home_domotique/services/bt_devices.dart';
import 'package:home_domotique/widgets/custom_button.dart';
import 'package:permission_handler/permission_handler.dart';

class RefreshSearchDevices extends StatefulWidget {
  const RefreshSearchDevices({super.key});

  @override
  State<RefreshSearchDevices> createState() => _RefreshSearchDevicesState();
}

class _RefreshSearchDevicesState extends State<RefreshSearchDevices> {
  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (context.mounted) {
      context.read<BTDevicesBloc>().add(SearchDevices(false));
    }
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BTDevicesBloc, BTDevices>(
      builder: (context, state) {
        return state.isSearching
            ? const CircularProgressIndicator(
                backgroundColor: accentColor,
                color: primaryTextColor,
              )
            : CustomButton(
                onPressed: () {
                  searchDevices();
                },
                icon: const Icon(
                  Icons.sync,
                  size: 40,
                ),
              );
      },
    );
  }

  void searchDevices() async {
    if (!(await requestBluetoothPermission())) {
      if (context.mounted) {
        context.read<BTDevicesBloc>().add(SearchDevices(false));
      }
      return;
    }

    await FlutterBluetoothSerial.instance
        .getBondedDevices()
        .then((bondedDevices) {
      if (context.mounted) {
        context.read<BTDevicesBloc>().add(SetBondedDevices(bondedDevices));
      }
    });

    await FlutterBluetoothSerial.instance.cancelDiscovery();

    if (context.mounted) {
      context.read<BTDevicesBloc>().add(SearchDevices(true));
    }

    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen(
      (discoveryResult) {
        context.read<BTDevicesBloc>().add(NewDeviceDiscovered(discoveryResult));
      },
      onError: (error) {
        if (context.mounted) {
          context.read<BTDevicesBloc>().add(SearchDevices(false));
        }
      },
    );
    _streamSubscription?.onDone(() {
      if (context.mounted) {
        context.read<BTDevicesBloc>().add(SearchDevices(false));
      }
    });
  }

  Future<bool> requestBluetoothPermission() async {
    PermissionStatus bluetoothStatus = await Permission.bluetoothScan.request();
    PermissionStatus locationStatus = await Permission.location.request();
    PermissionStatus connectStatus =
        await Permission.bluetoothConnect.request();

    return bluetoothStatus.isGranted &&
        locationStatus.isGranted &&
        connectStatus.isGranted;
  }
}
