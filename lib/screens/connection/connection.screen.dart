import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/services/bt_connection.bloc.dart';
import 'package:home_domotique/services/bt_devices.bloc.dart';
import 'package:home_domotique/widgets/custom_appbar.dart';
import 'package:home_domotique/widgets/custom_button.dart';
import 'package:home_domotique/widgets/device_list.dart';
import 'package:home_domotique/widgets/refresh_search_devices.dart';

class ConnectionScreen extends StatelessWidget {
  final BTConnectionBloc btConnectionBloc;
  final BTDevicesBloc btDevicesBloc;

  const ConnectionScreen({
    super.key,
    required this.btConnectionBloc,
    required this.btDevicesBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      floatingActionButton: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: btConnectionBloc),
          BlocProvider.value(value: btDevicesBloc),
        ],
        child: const RefreshSearchDevices(),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: btConnectionBloc),
          BlocProvider.value(value: btDevicesBloc),
        ],
        child: SafeArea(
          child: DefaultTextStyle(
            style: const TextStyle(
              color: primaryTextColor,
            ),
            child: Column(
              children: [
                CustomAppBar(
                  centered: const Text(
                    "Connexion",
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  leading: CustomButton(
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                const Flexible(
                  child: DeviceList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
