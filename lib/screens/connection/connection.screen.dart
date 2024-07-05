import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/services/bt_connection.bloc.dart';
import 'package:home_domotique/services/bt_devices.bloc.dart';
import 'package:home_domotique/widgets/bonded_device_list.dart';
import 'package:home_domotique/widgets/custom_appbar.dart';
import 'package:home_domotique/widgets/custom_button.dart';
import 'package:home_domotique/widgets/device_list.dart';
import 'package:home_domotique/widgets/refresh_search_devices.dart';

class ConnectionScreen extends StatefulWidget {
  final BTConnectionBloc btConnectionBloc;
  final BTDevicesBloc btDevicesBloc;

  const ConnectionScreen({
    super.key,
    required this.btConnectionBloc,
    required this.btDevicesBloc,
  });

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {
  bool isViewingBonded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: widget.btConnectionBloc),
          BlocProvider.value(value: widget.btDevicesBloc),
        ],
        child: const RefreshSearchDevices(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: widget.btConnectionBloc),
          BlocProvider.value(value: widget.btDevicesBloc),
        ],
        child: SafeArea(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: primaryTextColor,
            ),
            child: Column(
              children: [
                CustomAppBar(
                  centered: const Text(
                    "Connexion",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  leading: CustomButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  trailing: Switch(
                    value: isViewingBonded,
                    onChanged: (value) {
                      setState(() {
                        isViewingBonded = value;
                      });
                    },
                    trackColor: MaterialStateColor.resolveWith(
                      (states) {
                        return states.contains(MaterialState.selected)
                            ? darkPrimaryColor
                            : primaryTextColor;
                      },
                    ),
                    thumbColor: MaterialStateColor.resolveWith(
                      (states) {
                        return states.contains(MaterialState.selected)
                            ? primaryTextColor
                            : backgroundColor;
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: isViewingBonded
                      ? const BondedDeviceList()
                      : const DeviceList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
