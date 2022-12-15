import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'enums/workout_type.dart';

class Workout extends Equatable {
  final String? createUserId;
  final int? createdAt;
  final String? id;
  final int? lastUpdated;
  final String? lastUpdatedBy;
  final Map<String, String>? params;
  final List<String>? subjects;
  final String? tutorId;
  final String? workoutName;
  final WorkoutType? workoutSkeletonType;

  const Workout({
    this.createUserId,
    this.createdAt,
    this.id,
    this.lastUpdated,
    this.lastUpdatedBy,
    this.params,
    this.subjects,
    this.tutorId,
    this.workoutName,
    this.workoutSkeletonType,
  });

  Workout copyWith({
    String? createUserId,
    int? createdAt,
    String? id,
    int? lastUpdated,
    String? lastUpdatedBy,
    Map<String, String>? params,
    List<String>? subjects,
    String? tutorId,
    String? workoutName,
    WorkoutType? workoutSkeletonType,
  }) {
    return Workout(
      createUserId: createUserId ?? this.createUserId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      params: params ?? this.params,
      subjects: subjects ?? this.subjects,
      tutorId: tutorId ?? this.tutorId,
      workoutName: workoutName ?? this.workoutName,
      workoutSkeletonType: workoutSkeletonType ?? this.workoutSkeletonType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createUserId': createUserId,
      'createdAt': createdAt,
      'id': id,
      'lastUpdated': lastUpdated,
      'lastUpdatedBy': lastUpdatedBy,
      'params': params,
      'subjects': subjects,
      'tutorId': tutorId,
      'workoutName': workoutName,
      'workoutSkeletonType': workoutSkeletonType != null
          ? workoutTypeToString(workoutSkeletonType!)
          : null,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      createUserId: map['createUserId'],
      createdAt: map['createdAt']?.toInt(),
      id: map['id'],
      lastUpdated: map['lastUpdated']?.toInt(),
      lastUpdatedBy: map['lastUpdatedBy'],
      params: Map<String, String>.from(map['params']),
      subjects: List<String>.from(map['subjects']),
      tutorId: map['tutorId'],
      workoutName: map['workoutName'],
      workoutSkeletonType: map['workoutSkeletonType'] == null
          ? null
          : stringToWorkoutType(map['workoutSkeletonType']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Workout(createUserId: $createUserId, createdAt: $createdAt, id: $id, lastUpdated: $lastUpdated, lastUpdatedBy: $lastUpdatedBy, params: $params, subjects: $subjects, tutorId: $tutorId, workoutName: $workoutName, workoutSkeletonType: $workoutSkeletonType)';
  }

  @override
  List<Object?> get props => [
        createUserId,
        createdAt,
        id,
        lastUpdated,
        lastUpdatedBy,
        params,
        subjects,
        tutorId,
        workoutName,
        workoutSkeletonType,
      ];
}
