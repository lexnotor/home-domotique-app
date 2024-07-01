import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_domotique/services/room.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

sealed class RoomEvents {}

final class SwitchRoom extends RoomEvents {
  final bool roomState;
  final Room room;

  SwitchRoom(this.room, this.roomState);
}

final class CheckRoomsState extends RoomEvents {}

final class NewRoom extends RoomEvents {
  final int downCmd, upCmd;
  final String name;
  NewRoom(
    this.name,
    this.downCmd,
    this.upCmd,
  );
}

final class InitEvent extends RoomEvents {}

class RoomBloc extends Bloc<RoomEvents, List<Room>> {
  SharedPreferences? _prefs;
  static const _checkCmd = -1;

  RoomBloc(List<Room> rooms) : super(rooms) {
    on<SwitchRoom>((event, emit) {
      final newList = [...state];
      newList[newList.indexOf(event.room)] =
          event.room.copyWith(state: event.roomState);
      emit(newList);
    }, transformer: sequential());

    on<CheckRoomsState>((event, emit) {
      sendCmd(_checkCmd);
    }, transformer: sequential());

    on<NewRoom>((event, emit) async {
      try {
        final serializedRooms = await _deserialize();
        final newRoom = Room(
          id: serializedRooms.length,
          name: event.name,
          state: false,
          downCmd: event.downCmd,
          upCmd: event.upCmd,
        );

        _serialize([...serializedRooms, newRoom]);
        emit([...serializedRooms, newRoom]);
        add(CheckRoomsState());
      } catch (e) {
        //
      }
    });

    on<InitEvent>((event, emit) async {
      try {
        emit(await _deserialize());
        add(CheckRoomsState());
      } catch (e) {
        //
      }
    });
  }

  Future<List<Room>> _deserialize() async {
    _prefs ??= await SharedPreferences.getInstance();

    try {
      final json = jsonDecode(
        _prefs?.getString("rooms") ?? jsonEncode({"rooms": []}),
      ) as Map<String, dynamic>;

      final rooms = json["rooms"]
          ?.map<Room>(
            (json) => Room.fromJson(
              json,
            ),
          )
          .toList();
      return rooms ?? [];
    } catch (e) {
      throw Exception("CANNOT_ACCESS_SERIALIZED_ROOMS");
    }
  }

  Future<void> _serialize(List<Room> rooms) async {
    _prefs ??= await SharedPreferences.getInstance();

    try {
      final json = rooms
          .map(
            (romm) => romm.toJson(),
          )
          .toList();
      final str = jsonEncode({"rooms": json});

      _prefs?.setString("rooms", str);
    } catch (e) {
      throw Exception("CANNOT_SERIALIZE_ROOMS");
    }
  }

  Future<void> sendCmd(int cmd) async {}
}
