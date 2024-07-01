import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/widgets/custom_button.dart';

class DeviceCard extends StatelessWidget {
  final BluetoothDevice bluetoothDevice;
  const DeviceCard({
    super.key,
    required this.bluetoothDevice,
  });

  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
          icon: const Icon(Icons.bluetooth),
        ),
        trailing: CustomButton(
          onPressed: () {},
          icon: const Icon(Icons.share_outlined),
        ),
        title: Text(
          bluetoothDevice.name ?? bluetoothDevice.address,
          style: const TextStyle(color: primaryTextColor),
        ),
        subtitle: Text(
          bluetoothDevice.address,
          style: const TextStyle(color: accentColor),
        ),
      ),
    );
  }
}
