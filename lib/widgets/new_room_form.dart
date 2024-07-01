import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/services/room.bloc.dart';
import 'package:home_domotique/widgets/custom_textfield.dart';

class NewRoomForm extends StatefulWidget {
  const NewRoomForm({super.key});

  @override
  State<NewRoomForm> createState() => _NewRoomFormState();
}

class _NewRoomFormState extends State<NewRoomForm> {
  late TextEditingController nameCtrl, upCmdCtrl, downCmdCtrl;

  @override
  void initState() {
    nameCtrl = TextEditingController();
    upCmdCtrl = TextEditingController();
    downCmdCtrl = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    upCmdCtrl.dispose();
    downCmdCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            controller: nameCtrl,
            hintText: "Nom de la chambre",
            labelText: "DESIGNATION",
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: upCmdCtrl,
            hintText: "Chiffre pour HIGH",
            labelText: "HIGH",
          ),
          const SizedBox(height: 30),
          CustomTextField(
            controller: downCmdCtrl,
            hintText: "Chiffre pour LOW",
            labelText: "LOW",
          ),
          const SizedBox(height: 30),
          FilledButton(
            onPressed: () {
              submit();
              Navigator.of(context).pop();
            },
            style: IconButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text(
              "Ajouter",
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }

  void submit() {
    final name = nameCtrl.text;
    final upCmd = int.tryParse(upCmdCtrl.text),
        downCmd = int.tryParse(downCmdCtrl.text);
    if (upCmd == null || downCmd == null || name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Tous les champs sont obligatoires"),
        ),
      );
      return;
    }

    if (upCmd == downCmd) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("HIGH et LOW doivent être différent"),
        ),
      );
      return;
    }

    context.read<RoomBloc>()
      ..add(NewRoom(name, downCmd, upCmd))
      ..add(CheckRoomsState());
  }
}
