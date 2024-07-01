import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

@immutable
class BTDevices {
  final bool isSearching;
  final List<BluetoothDiscoveryResult> devices;
  final List<BluetoothDevice> bondedDevices;

  const BTDevices({
    this.isSearching = false,
    this.devices = const [],
    this.bondedDevices = const [],
  });

  BTDevices copyWith({
    bool? isSearching,
    List<BluetoothDiscoveryResult>? devices,
    List<BluetoothDevice>? bondedDevices,
  }) {
    final bTDevices = BTDevices(
      isSearching: isSearching ?? this.isSearching,
      devices: devices ?? this.devices,
      bondedDevices: bondedDevices ?? this.bondedDevices,
    );
    return bTDevices;
  }

  Map<String, dynamic> toJson() {
    return {
      "isSearching": isSearching,
      "devices": devices.length,
      "bondedDevices": bondedDevices.length,
    };
  }
}
