import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/services/bt_connection.bloc.dart';
import 'package:home_domotique/services/room.bloc.dart';
import 'package:home_domotique/services/room.dart';

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    void switchCmd(bool switchOn) async {
      final connection = context.read<BTConnectionBloc>().state.connection;
      if (connection == null || !connection.isConnected) return;

      connection.output.add(Uint8List.fromList(
        utf8.encode(
          switchOn ? room.upCmd.toString() : room.downCmd.toString(),
        ),
      ));
      try {
        await connection.output.allSent;
        if (context.mounted) {
          context.read<RoomBloc>().add(
                SwitchRoom(room, switchOn),
              );
        }
      } catch (e) {
        //
      }
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Switch(
            value: room.state,
            onChanged: (val) {
              switchCmd(val);
            },
            trackColor: MaterialStateColor.resolveWith(
              (states) {
                return states.contains(MaterialState.selected)
                    ? darkPrimaryColor
                    : primaryTextColor;
              },
            ),
            thumbColor: MaterialStateColor.resolveWith(
              (states) {
                return states.contains(MaterialState.selected)
                    ? primaryTextColor
                    : backgroundColor;
              },
            ),
          ),
          Text(
            room.name,
            style: const TextStyle(
              color: secondaryTextColor,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
