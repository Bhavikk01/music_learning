import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'enums/homework_status.dart';
import 'enums/workout_type.dart';

class HomeWork extends Equatable {
  final int? attempedTime;
  final String? courseId;
  final String? createUserId;
  final int? createdAt;
  final String? id;
  final int? lastUpdated;
  final String? lastUpdatedBy;
  final String? name;
  final HomeworkStatus? state;
  final Map<String, String>? submissionValues;
  final String? teacherRemarks;
  final String? tutorId;
  final String? userId;
  final String? workoutId;
  final WorkoutType? workoutSkeletonType;

  const HomeWork({
    this.attempedTime,
    this.courseId,
    this.createUserId,
    this.createdAt,
    this.id,
    this.lastUpdated,
    this.lastUpdatedBy,
    this.name,
    this.state,
    this.submissionValues,
    this.teacherRemarks,
    this.tutorId,
    this.userId,
    this.workoutId,
    this.workoutSkeletonType,
  });

  HomeWork copyWith({
    int? attempedTime,
    String? courseId,
    String? createUserId,
    int? createdAt,
    String? id,
    int? lastUpdated,
    String? lastUpdatedBy,
    String? name,
    HomeworkStatus? state,
    Map<String, String>? submissionValues,
    String? teacherRemarks,
    String? tutorId,
    String? userId,
    String? workoutId,
    WorkoutType? workoutSkeletonType,
  }) {
    return HomeWork(
      attempedTime: attempedTime ?? this.attempedTime,
      courseId: courseId ?? this.courseId,
      createUserId: createUserId ?? this.createUserId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      name: name ?? this.name,
      state: state ?? this.state,
      submissionValues: submissionValues ?? this.submissionValues,
      teacherRemarks: teacherRemarks ?? this.teacherRemarks,
      tutorId: tutorId ?? this.tutorId,
      userId: userId ?? this.userId,
      workoutId: workoutId ?? this.workoutId,
      workoutSkeletonType: workoutSkeletonType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attempedTime': attempedTime,
      'courseId': courseId,
      'createUserId': createUserId,
      'createdAt': createdAt,
      'id': id,
      'lastUpdated': lastUpdated,
      'lastUpdatedBy': lastUpdatedBy,
      'name': name,
      'state': state == null ? null : homeworkStatusToString(state!),
      'submissionValues': submissionValues,
      'teacherRemarks': teacherRemarks,
      'tutorId': tutorId,
      'userId': userId,
      'workoutId': workoutId,
      'workoutSkeletonType': workoutSkeletonType,
    };
  }

  factory HomeWork.fromMap(Map<String, dynamic> map) {
    return HomeWork(
      attempedTime: map['attempedTime']?.toInt(),
      courseId: map['courseId'],
      createUserId: map['createUserId'],
      createdAt: map['createdAt']?.toInt(),
      id: map['id'],
      lastUpdated: map['lastUpdated']?.toInt(),
      lastUpdatedBy: map['lastUpdatedBy'],
      name: map['name'],
      state: map['state'] != null ? stringToHomeworkStatus(map['state']) : null,
      // submissionValues: map['submissionValues'] == null
      //     ? {'additionalProp1': 'Intro Video', 'additionalProp2': 'Intro Audio'}
      //     : Map<String, String>.from(map['submissionValues']),
      submissionValues: map['submissionValues'] == null
          ? {'additionalProp1': 'Intro Video', 'additionalProp2': 'Intro Audio'}
          : {'additionalProp1': 'Intro Video', 'additionalProp2': 'Intro Audio'},
      teacherRemarks: map['teacherRemarks'],
      tutorId: map['tutorId'],
      userId: map['userId'],
      workoutId: map['workoutId'],
      workoutSkeletonType: map['workoutSkeletonType'] == null
          ? null
          : stringToWorkoutType(
              map['workoutSkeletonType'],
            ),
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeWork.fromJson(String source) =>
      HomeWork.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HomeWork(attempedTime: $attempedTime, courseId: $courseId, createUserId: $createUserId, createdAt: $createdAt, id: $id, lastUpdated: $lastUpdated, lastUpdatedBy: $lastUpdatedBy, name: $name, state: $state, submissionValues: $submissionValues, teacherRemarks: $teacherRemarks, tutorId: $tutorId, userId: $userId, workoutId: $workoutId, workoutSkeletonType: $workoutSkeletonType)';
  }

  @override
  List<Object?> get props => [
        attempedTime,
        courseId,
        createUserId,
        createdAt,
        id,
        lastUpdated,
        lastUpdatedBy,
        name,
        state,
        submissionValues,
        teacherRemarks,
        tutorId,
        userId,
        workoutId,
      ];
}
