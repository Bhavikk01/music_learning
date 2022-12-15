import 'dart:convert';

import 'package:equatable/equatable.dart';

class TutorMetrics extends Equatable {
  final int? sessionsCompleted;
  final int? studentsEnrolled;
  final int? workoutsAssigned;

  const TutorMetrics({
    this.studentsEnrolled,
    this.sessionsCompleted,
    this.workoutsAssigned
  });

  Map<String, dynamic> toMap() {
    return {
      'studentsEnrolled': studentsEnrolled,
      'sessionsCompleted': sessionsCompleted,
      'workoutsAssigned': workoutsAssigned
    };
  }

  factory TutorMetrics.fromMap(Map<String, dynamic> map) {
    return TutorMetrics(
        studentsEnrolled: map['studentsEnrolled'],
        sessionsCompleted: map['sessionsCompleted'],
      workoutsAssigned: map['workoutsAssigned']
    );
  }

  String toJson() => json.encode(toMap());

  @override
  // TODO: implement props
  List<Object?> get props => [
    studentsEnrolled,
    sessionsCompleted,
    workoutsAssigned
  ];
}