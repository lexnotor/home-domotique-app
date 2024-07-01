import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/constant.dart';
import 'package:home_domotique/services/room.bloc.dart';
import 'package:home_domotique/widgets/custom_button.dart';
import 'package:home_domotique/widgets/new_room_form.dart';

class AddRoom extends StatelessWidget {
  const AddRoom({super.key});

  @override
  Widget build(BuildContext context) {
    void showSheet() {
      showModalBottomSheet(
          backgroundColor: surfaceColor,
          isScrollControlled: true,
          enableDrag: true,
          showDragHandle: true,
          context: context,
          builder: (buildCtx) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: context.read<RoomBloc>(),
                )
              ],
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const SizedBox(
                  height: 400,
                  child: SingleChildScrollView(
                    child: NewRoomForm(),
                  ),
                ),
              ),
            );
          });
    }

    return CustomButton(
      onPressed: () {
        showSheet();
      },
      icon: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }
}
