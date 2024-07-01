import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/screens/connection/connection.screen.dart';
import 'package:home_domotique/services/bt_connection.bloc.dart';
import 'package:home_domotique/services/bt_devices.bloc.dart';
import 'package:home_domotique/services/bt_devices.dart';
import 'package:home_domotique/services/room.bloc.dart';
import 'package:home_domotique/widgets/add_room.dart';
import 'package:home_domotique/widgets/connection_status.dart';
import 'package:home_domotique/widgets/custom_appbar.dart';
import 'package:home_domotique/widgets/custom_button.dart';
import 'package:home_domotique/widgets/room_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BTConnectionBloc(),
        ),
        BlocProvider(
          create: (context) {
            return BTDevicesBloc(
              const BTDevices(),
            );
          },
        ),
        BlocProvider(
          create: (context) => RoomBloc([])
            ..add(
              InitEvent(),
            ),
        ),
      ],
      child: Scaffold(
        backgroundColor: backgroundColor,
        floatingActionButton: const AddRoom(),
        body: Container(
          color: backgroundColor,
          child: SafeArea(
            child: DefaultTextStyle(
              style: const TextStyle(color: primaryTextColor),
              child: Column(
                children: [
                  CustomAppBar(
                    leading: const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    trailing: Builder(
                      builder: (buildCtx) {
                        return CustomButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (materialCtx) => ConnectionScreen(
                                  btConnectionBloc:
                                      buildCtx.read<BTConnectionBloc>(),
                                  btDevicesBloc: buildCtx.read<BTDevicesBloc>(),
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.bluetooth),
                        );
                      },
                    ),
                  ),
                  const ConnectionStatus(),
                  const SizedBox(height: 10),
                  const Flexible(
                    child: RoomList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
