import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'enums/course_status.dart';
import 'enums/pricing_plan.dart';
import 'enums/subject.dart';

class Course extends Equatable {
  final List<String>? assignedWorkoutId;
  final CourseStatus? courseStatus;
  final String? createUserId;
  final int? createdAt;
  final String? currentTutorId;
  final String? id;
  final int? lastUpdated;
  final String? lastUpdatedBy;
  final String? name;
  final List<String>? pastTutorIds;
  final PricingPlan? pricingPlan;
  final List<String>? sessionId;
  final int? sessionsTaken;
  final int? slotsLeft;
  final Subject? subject;
  final int? totalCourseCostYet;
  final String? userId;

  const Course({
    this.assignedWorkoutId,
    this.courseStatus,
    this.createUserId,
    this.createdAt,
    this.currentTutorId,
    this.id,
    this.lastUpdated,
    this.lastUpdatedBy,
    this.name,
    this.pastTutorIds,
    this.pricingPlan,
    this.sessionId,
    this.sessionsTaken,
    this.slotsLeft,
    this.subject,
    this.totalCourseCostYet,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'assignedWorkoutId': assignedWorkoutId,
      'courseStatus': courseStatusToString(courseStatus),
      'createUserId': createUserId,
      'createdAt': createdAt,
      'currentTutorId': currentTutorId,
      'id': id,
      'lastUpdated': lastUpdated,
      'lastUpdatedBy': lastUpdatedBy,
      'name': name,
      'pastTutorIds': pastTutorIds,
      'pricingPlan': pricingPlanToString(pricingPlan),
      'sessionId': sessionId,
      'sessionsTaken': sessionsTaken,
      'slotsLeft': slotsLeft,
      'subject': subjectToString(subject),
      'totalCourseCostYet': totalCourseCostYet,
      'userId': userId,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      assignedWorkoutId: map['assignedWorkoutId'] == null
          ? null
          : List<String>.from(map['assignedWorkoutId']),
      courseStatus: map['courseStatus'] == null
          ? null
          : getCourseStatusFromString(map['courseStatus']),
      createUserId: map['createUserId'],
      createdAt: map['createdAt']?.toInt(),
      currentTutorId: map['currentTutorId'],
      id: map['id'],
      lastUpdated: map['lastUpdated']?.toInt(),
      lastUpdatedBy: map['lastUpdatedBy'],
      name: map['name'],
      pastTutorIds: map['pastTutorIds'] == null
          ? null
          : List<String>.from(map['pastTutorIds']),
      pricingPlan: (map['pricingPlan'] == null)
          ? null
          : getPricingPlanFromString(map['pricingPlan']),
      //commented because throwing error
      // sessionId: (map['sessionId'] == null || (map['sessionId'] == [null]))
      //     ? null
      //     : List<String>.from(map['sessionId']),
      sessionsTaken: map['sessionsTaken']?.toInt(),
      slotsLeft: map['slotsLeft']?.toInt(),
      subject:
          map['subject'] == null ? null : getSubjectFromString(map['subject']),
      totalCourseCostYet: map['totalCourseCostYet']?.toInt(),
      userId: map['userId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(assignedWorkoutId: $assignedWorkoutId, createUserId: $createUserId, createdAt: $createdAt, currentTutorId: $currentTutorId, id: $id, lastUpdated: $lastUpdated, lastUpdatedBy: $lastUpdatedBy, name: $name, pastTutorIds: $pastTutorIds, pricingPlan: $pricingPlan, sessionId: $sessionId, sessionsTaken: $sessionsTaken, slotsLeft: $slotsLeft, subject: $subject, totalCourseCostYet: $totalCourseCostYet, userId: $userId)';
  }

  @override
  List<Object?> get props => [
        assignedWorkoutId,
        courseStatus,
        createUserId,
        createdAt,
        currentTutorId,
        id,
        lastUpdated,
        lastUpdatedBy,
        name,
        pastTutorIds,
        pricingPlan,
        sessionId,
        sessionsTaken,
        slotsLeft,
        subject,
        totalCourseCostYet,
        userId,
      ];
}
