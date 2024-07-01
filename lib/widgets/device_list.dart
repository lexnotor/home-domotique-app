import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/services/bt_devices.bloc.dart';
import 'package:home_domotique/services/bt_devices.dart';
import 'package:home_domotique/widgets/device_card.dart';

class DeviceList extends StatelessWidget {
  const DeviceList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BTDevicesBloc, BTDevices>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.devices.length,
          itemBuilder: (context, index) {
            final result = state.devices[index];

            return DeviceCard(
              discoveryResult: result,
            );
          },
          padding: const EdgeInsets.all(20),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 20);
          },
        );
      },
    );
  }
}
