import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:home_domotique/services/bt_connection.dart';

sealed class BTConnectionEvents {}

final class CheckBTState extends BTConnectionEvents {}

final class UpdateBluetoothConnection extends BTConnectionEvents {
  final BluetoothConnection? bluetoothConnection;
  UpdateBluetoothConnection(this.bluetoothConnection);
}

final class GetBTAddressField extends BTConnectionEvents {}

final class GetBTName extends BTConnectionEvents {}

class BTConnectionBloc extends Bloc<BTConnectionEvents, BTConnection> {
  BTConnectionBloc() : super(const BTConnection()) {
    on<CheckBTState>(
      (event, emit) async => emit(
        state.copyWith(
          state: await checkState(),
        ),
      ),
    );

    on<GetBTAddressField>((event, emit) => null);

    on<UpdateBluetoothConnection>((event, emit) {
      if (event.bluetoothConnection?.isConnected ?? false) {
        event.bluetoothConnection?.input?.listen((event) {}).onDone(() {
          add(UpdateBluetoothConnection(null));
        });
      }
      emit(
        state.copyWith(
          connection: event.bluetoothConnection,
          setToNull: true,
        ),
      );
    });
  }

  Future<BluetoothState> checkState() async {
    return FlutterBluetoothSerial.instance.state;
  }

  Future<String> getAddressField() async {
    final isEnalble = await FlutterBluetoothSerial.instance.isEnabled ?? false;
    return isEnalble
        ? (await FlutterBluetoothSerial.instance.address) ?? ""
        : "";
  }

  Future<String> getName() async {
    final isEnalble = await FlutterBluetoothSerial.instance.isEnabled ?? false;
    return isEnalble ? (await FlutterBluetoothSerial.instance.name) ?? "" : "";
  }
}
