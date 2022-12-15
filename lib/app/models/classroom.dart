import 'dart:convert';

import 'package:equatable/equatable.dart';

class ClassRoom extends Equatable {
  final int? endTime;
  final String? joiningLink;
  final int? startTime;

  const ClassRoom({
    this.endTime,
    this.joiningLink,
    this.startTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'endTime': endTime,
      'joiningLink': joiningLink,
      'startTime': startTime,
    };
  }

  factory ClassRoom.fromMap(Map<String, dynamic> map) {
    return ClassRoom(
      endTime: map['endTime']?.toInt(),
      joiningLink: map['joiningLink'],
      startTime: map['startTime']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassRoom.fromJson(String source) =>
      ClassRoom.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        endTime,
        joiningLink,
        startTime,
      ];

  @override
  String toString() =>
      'ClassRoom(endTime: $endTime, joiningLink: $joiningLink, startTime: $startTime)';
}
