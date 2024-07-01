import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:home_domotique/services/bt_devices.dart';

sealed class BTDevicesEvents {}

final class SearchDevices extends BTDevicesEvents {
  final bool isSearching;
  SearchDevices([this.isSearching = true]);
}

final class SetBondedDevices extends BTDevicesEvents {
  final List<BluetoothDevice> bondedDevices;

  SetBondedDevices(this.bondedDevices);
}

final class NewDeviceDiscovered extends BTDevicesEvents {
  final BluetoothDiscoveryResult discoveryResult;
  NewDeviceDiscovered(this.discoveryResult);
}

class BTDevicesBloc extends Bloc<BTDevicesEvents, BTDevices> {
  BTDevicesBloc(BTDevices btDevices) : super(btDevices) {
    on<SearchDevices>(
      (event, emit) {
        emit(state.copyWith(
          isSearching: event.isSearching,
          devices: event.isSearching ? [] : null,
        ));
      },
      transformer: sequential(),
    );

    on<SetBondedDevices>(
      (event, emit) {
        emit(state.copyWith(
          bondedDevices: [...state.bondedDevices, ...event.bondedDevices],
        ));
      },
      transformer: sequential(),
    );

    on<NewDeviceDiscovered>(
      (event, emit) {
        final existingIndex = state.devices.indexWhere((device) =>
            device.device.address == event.discoveryResult.device.address);
        List<BluetoothDiscoveryResult> newDevices;
        if (existingIndex >= 0) {
          newDevices = [...state.devices];
          newDevices[existingIndex] = event.discoveryResult;
          emit(state.copyWith(devices: newDevices));
        } else {
          newDevices = [...state.devices, event.discoveryResult];
          emit(state.copyWith(devices: newDevices));
        }
      },
      transformer: sequential(),
    );
  }
}
