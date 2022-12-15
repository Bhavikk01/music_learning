import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'address.dart';
import 'enums/subject.dart';

class Tutor extends Equatable {
  final String? id;
  final String? name;
  final String? description;
  final int? lastUpdated;
  final int? rating;
  final int? createdAt;
  final String? lastUpdatedBy;
  final String? createUserId;
  final String? mobile;
  final List<Subject>? subjectsTaught;
  final Address? address;
  final String? imageUrl;
  final List<String>? introVideoUrl;
  final int? dob;
  final String? timeTableRule;
  final int? noOfSession;

  const Tutor({
    this.id,
    this.lastUpdated,
    this.createdAt,
    this.lastUpdatedBy,
    this.createUserId,
    this.mobile,
    this.name,
    this.subjectsTaught,
    this.address,
    this.description,
    this.imageUrl,
    this.introVideoUrl,
    this.dob,
    this.timeTableRule,
    this.rating,
    this.noOfSession,
  });

  Tutor copyWith({
    String? id,
    int? lastUpdated,
    int? createdAt,
    String? lastUpdatedBy,
    String? createUserId,
    String? mobile,
    String? name,
    List<Subject>? subjectsTaught,
    Address? address,
    String? description,
    String? imageUrl,
    List<String>? introVideoUrl,
    int? dob,
    String? timeTableRule,
    int? rating,
    int? noOfSession,
  }) {
    return Tutor(
      id: id ?? this.id,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      createUserId: createUserId ?? this.createUserId,
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      subjectsTaught: subjectsTaught ?? this.subjectsTaught,
      address: address ?? this.address,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      introVideoUrl: introVideoUrl ?? this.introVideoUrl,
      dob: dob ?? this.dob,
      timeTableRule: timeTableRule ?? this.timeTableRule,
      rating: rating ?? this.rating,
      noOfSession: noOfSession ?? this.noOfSession,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lastUpdated': lastUpdated,
      'createdAt': createdAt,
      'lastUpdatedBy': lastUpdatedBy,
      'createUserId': createUserId,
      'mobile': mobile,
      'name': name,
      'subjectsTaught': subjectsTaught,
      'address': address?.toMap(),
      'description': description,
      'imageUrl': imageUrl,
      'introVideoUrl': introVideoUrl,
      'dob': dob,
      'timeTableRule': timeTableRule,
      'rating': rating,
      'noOfSession': noOfSession,
    };
  }

  factory Tutor.fromMap(Map<String, dynamic> map) {
    return Tutor(
      id: map['id'],
      lastUpdated: map['lastUpdated']?.toInt(),
      createdAt: map['createdAt']?.toInt(),
      lastUpdatedBy: map['lastUpdatedBy'],
      createUserId: map['createUserId'],
      mobile: map['mobile'],
      name: map['name'],
      subjectsTaught:
          (map['subjectsTaught'] == null || map['subjectsTaught'].isEmpty)
              ? null
              : getListOfSubjectFromString(map['subjectsTaught']),
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      description: map['description'],
      imageUrl: map['imageUrl'],
      introVideoUrl: List<String>.from(map['introVideoUrl']),
      dob: map['dob']?.toInt(),
      timeTableRule: map['timeTableRule'],
      rating: map['rating']?.toInt(),
      noOfSession: map['noOfSession']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Tutor.fromJson(String source) => Tutor.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tutor(id: $id, lastUpdated: $lastUpdated, createdAt: $createdAt, lastUpdatedBy: $lastUpdatedBy, createUserId: $createUserId, mobile: $mobile, name: $name, subjectsTaught: $subjectsTaught, address: $address, description: $description, imageUrl: $imageUrl, introVideoUrl: $introVideoUrl, dob: $dob, timeTableRule: $timeTableRule, rating: $rating, noOfSession: $noOfSession)';
  }

  @override
  List<Object?> get props => [
        id,
        lastUpdated,
        createUserId,
        createdAt,
        lastUpdated,
        lastUpdatedBy,
        mobile,
        name,
        subjectsTaught,
        address,
        description,
        imageUrl,
        introVideoUrl,
        dob,
        timeTableRule,
        rating,
        noOfSession,
      ];
}
