import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

@immutable
class BTDevices {
  final bool isSearching;
  final List<BluetoothDiscoveryResult> devices;

  const BTDevices({
    this.isSearching = false,
    this.devices = const [],
  });

  BTDevices copyWith({
    bool? isSearching,
    List<BluetoothDiscoveryResult>? devices,
  }) {
    return BTDevices(
      isSearching: isSearching ?? this.isSearching,
      devices: devices ?? this.devices,
    );
  }
}
