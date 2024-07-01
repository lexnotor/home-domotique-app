import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/services/bt_connection.bloc.dart';
import 'package:home_domotique/services/bt_connection.dart';

class ConnectionStatus extends StatefulWidget {
  const ConnectionStatus({super.key});

  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  @override
  void initState() {
    Future.delayed(Durations.long2).then(
      (value) => context.read<BTConnectionBloc>().add(CheckBTState()),
    );
    FlutterBluetoothSerial.instance.onStateChanged().listen((event) {
      context.read<BTConnectionBloc>().add(CheckBTState());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BTConnectionBloc, BTConnection>(
      builder: (context, state) {
        final isConnected = state.state == BluetoothState.STATE_ON ||
            state.state == BluetoothState.STATE_BLE_ON;

        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: isConnected ? darkPrimaryColor : errorColor,
          ),
          child: Text(isConnected ? "Connecté" : "Non Connecté"),
        );
      },
    );
  }
}
