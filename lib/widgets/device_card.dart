import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/services/bt_connection.bloc.dart';
import 'package:home_domotique/services/bt_devices.bloc.dart';
import 'package:home_domotique/widgets/custom_button.dart';

class DeviceCard extends StatelessWidget {
  final BluetoothDiscoveryResult discoveryResult;
  const DeviceCard({
    super.key,
    required this.discoveryResult,
  });

  @override
  Widget build(BuildContext context) {
    void connectTo() async {
      try {
        final connection =
            await BluetoothConnection.toAddress(discoveryResult.device.address);

        if (context.mounted) {
          context
              .read<BTConnectionBloc>()
              .add(UpdateBluetoothConnection(connection));

          final deviceData = discoveryResult.device;
          final rssi = discoveryResult.rssi;

          context.read<BTDevicesBloc>().add(
                NewDeviceDiscovered(
                  BluetoothDiscoveryResult(
                    device: BluetoothDevice(
                      isConnected: connection.isConnected,
                      address: deviceData.address,
                      name: deviceData.name,
                      type: deviceData.type,
                      bondState: deviceData.isBonded
                          ? BluetoothBondState.bonded
                          : BluetoothBondState.none,
                    ),
                    rssi: rssi,
                  ),
                ),
              );
        }
      } catch (e) {
        //
      }
    }

    void bondeTo() async {
      if (discoveryResult.device.isBonded) {
        return;
      }
      try {
        final bonded = await FlutterBluetoothSerial.instance
            .bondDeviceAtAddress(discoveryResult.device.address);
        if (bonded == null) {
          return;
        }

        if (context.mounted) {
          final deviceData = discoveryResult.device;
          final rssi = discoveryResult.rssi;

          context.read<BTDevicesBloc>().add(
                NewDeviceDiscovered(
                  BluetoothDiscoveryResult(
                    device: BluetoothDevice(
                      address: deviceData.address,
                      name: deviceData.name,
                      type: deviceData.type,
                      bondState: bonded
                          ? BluetoothBondState.bonded
                          : BluetoothBondState.none,
                    ),
                    rssi: rssi,
                  ),
                ),
              );
        }
      } catch (e) {
        //
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: CustomButton(
          onPressed: () {
            bondeTo();
          },
          icon: Icon(
            Icons.bluetooth,
            color: discoveryResult.device.isBonded
                ? darkPrimaryColor
                : primaryTextColor,
          ),
        ),
        trailing: CustomButton(
          onPressed: () {
            connectTo();
          },
          icon: Icon(
            Icons.share_outlined,
            color: discoveryResult.device.isConnected
                ? darkPrimaryColor
                : primaryTextColor,
          ),
        ),
        title: Text(
          discoveryResult.device.name ?? discoveryResult.device.address,
          style: const TextStyle(color: primaryTextColor),
        ),
        subtitle: Text(
          discoveryResult.device.address,
          style: const TextStyle(color: accentColor),
        ),
      ),
    );
  }
}
