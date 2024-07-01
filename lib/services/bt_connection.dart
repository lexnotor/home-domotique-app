import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

@immutable
class BTConnection {
  final BluetoothState state;
  final String address, name;
  final BluetoothConnection? connection;

  const BTConnection(
      {this.state = BluetoothState.STATE_OFF,
      this.address = "",
      this.name = "",
      this.connection});

  BTConnection copyWith({
    BluetoothState? state,
    String? address,
    String? name,
    BluetoothConnection? connection,
  }) {
    return BTConnection(
      state: state ?? this.state,
      address: address ?? this.address,
      name: name ?? this.name,
      connection: connection ?? this.connection,
    );
  }
}
