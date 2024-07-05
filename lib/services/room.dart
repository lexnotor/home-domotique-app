import 'package:flutter/material.dart';

@immutable
class Room {
  final bool state;
  final String name, id;
  final int upCmd, downCmd;

  const Room({
    required this.id,
    required this.name,
    required this.state,
    required this.downCmd,
    required this.upCmd,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json["id"] is int ? (json["id"] as int).toString() : json["id"],
      name: json["name"],
      state: json["state"],
      downCmd: json["downCmd"],
      upCmd: json["upCmd"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "state": state,
      "downCmd": downCmd,
      "upCmd": upCmd,
    };
  }

  Room copyWith({
    bool? state,
    String? name,
    int? upCmd,
    int? downCmd,
  }) {
    return Room(
      id: id,
      name: name ?? this.name,
      state: state ?? this.state,
      downCmd: downCmd ?? this.downCmd,
      upCmd: upCmd ?? this.upCmd,
    );
  }
}
