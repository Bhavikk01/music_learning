import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'classroom.dart';
import 'enums/session_status.dart';
import 'enums/session_type.dart';
import 'enums/subject.dart';
import 'student_session_feedback.dart';
import 'tutor_session_feedback.dart';

class Session extends Equatable {
  final ClassRoom? classRoom;
  final String? courseId;
  final String? createUserId;
  final int? createdAt;
  final int? endTime;
  final String? id;
  final int? lastUpdated;
  final String? lastUpdatedBy;
  final SessionStatus? sessionStatus;
  final SessionType? sessionType;
  final int? startTime;
  final StudentSessionFeedback? studentSessionFeedback;
  final Subject? subject;
  final String? topic;
  final String? tutorId;
  final TutorSessionFeedback? tutorSessionFeedback;
  final String? userId;

  const Session({
    this.classRoom,
    this.courseId,
    this.createUserId,
    this.createdAt,
    this.endTime,
    this.id,
    this.lastUpdated,
    this.lastUpdatedBy,
    this.sessionStatus,
    this.sessionType,
    this.startTime,
    this.studentSessionFeedback,
    this.subject,
    this.topic,
    this.tutorId,
    this.tutorSessionFeedback,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'classRoom': classRoom?.toMap(),
      'courseId': courseId,
      'createUserId': createUserId,
      'createdAt': createdAt,
      'endTime': endTime,
      'id': id,
      'lastUpdated': lastUpdated,
      'lastUpdatedBy': lastUpdatedBy,
      'sessionStatus': sessionStatusToString(sessionStatus),
      'sessionType':
          sessionTypeToString(sessionType ?? SessionType.musicDirect),
      'startTime': startTime,
      'studentSessionFeedback': studentSessionFeedback?.toMap(),
      'subject': subjectToString(subject),
      'topic': topic,
      'tutorId': tutorId,
      'tutorSessionFeedback': tutorSessionFeedback?.toMap(),
      'userId': userId,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      classRoom:
          map['classRoom'] != null ? ClassRoom.fromMap(map['classRoom']) : null,
      courseId: map['courseId'],
      createUserId: map['createUserId'],
      createdAt: map['createdAt']?.toInt(),
      endTime: map['endTime']?.toInt(),
      id: map['id'],
      lastUpdated: map['lastUpdated']?.toInt(),
      lastUpdatedBy: map['lastUpdatedBy'],
      sessionStatus: getSessionStatusFromString(map['sessionStatus']),
      sessionType: getSessionTypeFromString(map['sessionType']),
      startTime: map['startTime']?.toInt(),
      studentSessionFeedback: map['studentSessionFeedback'] != null
          ? StudentSessionFeedback.fromMap(map['studentSessionFeedback'])
          : null,
      subject:
          map['subject'] == null ? null : getSubjectFromString(map['subject']),
      topic: map['topic'],
      tutorId: map['tutorId'],
      tutorSessionFeedback: map['tutorSessionFeedback'] != null
          ? TutorSessionFeedback.fromMap(map['tutorSessionFeedback'])
          : null,
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Session(classRoom: $classRoom, courseId: $courseId, createUserId: $createUserId, createdAt: $createdAt, endTime: $endTime, id: $id, lastUpdated: $lastUpdated, lastUpdatedBy: $lastUpdatedBy, startTime: $startTime, studentSessionFeedback: $studentSessionFeedback, subject: $subject, topic: $topic, tutorId: $tutorId, tutorSessionFeedback: $tutorSessionFeedback, userId: $userId)';
  }

  @override
  List<Object?> get props => [
        classRoom,
        courseId,
        createUserId,
        createdAt,
        endTime,
        id,
        lastUpdated,
        lastUpdatedBy,
        sessionStatus,
        sessionType,
        startTime,
        studentSessionFeedback,
        subject,
        topic,
        tutorId,
        tutorSessionFeedback,
        userId,
      ];
}
