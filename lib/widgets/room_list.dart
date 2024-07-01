import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/services/room.bloc.dart';
import 'package:home_domotique/services/room.dart';
import 'package:home_domotique/widgets/room_card.dart';

class RoomList extends StatelessWidget {
  const RoomList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, List<Room>>(
      bloc: context.read<RoomBloc>(),
      builder: (context, state) {
        return state.isNotEmpty
            ? GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.all(20),
                children: state.map((e) => const RoomCard()).toList(),
              )
            : Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 23,
                      color: primaryColor,
                    ),
                    text: "Cliquez sur ",
                    children: [
                      TextSpan(
                        text: '"Plus" ',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      TextSpan(text: 'pour ajouter \nune commande'),
                    ],
                  ),
                ),
              );
      },
    );
  }
}
