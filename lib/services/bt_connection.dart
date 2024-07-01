import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

@immutable
class BTConnection {
  final BluetoothState state;
  final String address, name;

  const BTConnection({
    this.state = BluetoothState.STATE_OFF,
    this.address = "",
    this.name = "",
  });

  BTConnection copyWith({
    BluetoothState? state,
    String? address,
    String? name,
  }) {
    return BTConnection(
      state: state ?? this.state,
      address: address ?? this.address,
      name: name ?? this.name,
    );
  }
}
