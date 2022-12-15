import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

import 'address.dart';
import 'enums/user_status.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  Address? address;
  @HiveField(1)
  String? authToken;
  @HiveField(2)
  String? createUserId;
  @HiveField(3)
  int? createdAt;
  @HiveField(4)
  String? currentPreferedHobby;
  @HiveField(5)
  int? dob;
  @HiveField(6)
  String? emailId;
  @HiveField(7)
  String? id;
  @HiveField(8)
  int? lastUpdated;
  @HiveField(9)
  String? lastUpdatedBy;
  @HiveField(10)
  String mobile;
  @HiveField(11)
  String? name;
  @HiveField(12)
  UserStatus userStatus;

  User({
    this.address,
    this.authToken,
    this.createUserId = 'pickit_app',
    this.createdAt,
    this.currentPreferedHobby,
    this.dob,
    this.emailId,
    this.id,
    this.lastUpdated,
    this.lastUpdatedBy,
    required this.mobile,
    this.name,
    required this.userStatus,
  });

  User copyWith({
    Address? address,
    String? authToken,
    String? createUserId,
    int? createdAt,
    String? currentPreferedHobby,
    int? dob,
    String? emailId,
    String? id,
    int? lastUpdated,
    String? lastUpdatedBy,
    String? mobile,
    String? name,
    UserStatus? userStatus,
  }) {
    return User(
      address: address ?? this.address,
      authToken: authToken ?? this.authToken,
      createUserId: createUserId ?? this.createUserId,
      createdAt: createdAt ?? this.createdAt,
      currentPreferedHobby: currentPreferedHobby ?? this.currentPreferedHobby,
      dob: dob ?? this.dob,
      emailId: emailId ?? this.emailId,
      id: id ?? this.id,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      lastUpdatedBy: lastUpdatedBy ?? this.lastUpdatedBy,
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (address != null) 'address': address?.toMap(),
      if (authToken != null) 'authToken': authToken,
      if (address != null) 'createUserId': createUserId,
      if (createdAt != null) 'createdAt': createdAt,
      if (currentPreferedHobby != null)
        'currentPreferedHobby': currentPreferedHobby,
      if (dob != null) 'dob': dob,
      if (emailId != null) 'emailId': emailId,
      if (id != null) 'id': id,
      if (lastUpdated != null) 'lastUpdated': lastUpdated,
      if (lastUpdatedBy != null) 'lastUpdatedBy': lastUpdatedBy,
      if (name != null) 'name': name,
      'mobile': mobile,
      'userStatus': _userStatusToMap(userStatus),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      authToken: map['authToken'],
      createUserId: map['createUserId'] ?? 'pickit_app',
      createdAt: map['createdAt']?.toInt(),
      currentPreferedHobby: map['currentPreferedHobby'],
      dob: map['dob']?.toInt(),
      emailId: map['emailId'],
      id: map['id'],
      lastUpdated: map['lastUpdated']?.toInt(),
      lastUpdatedBy: map['lastUpdatedBy'],
      mobile: map['mobile'] ?? '',
      name: map['name'],
      userStatus: map['userStatus'] != null
          ? _userStatusFromMap(map['userStatus'])
          : UserStatus.signedUp,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(address: $address, authToken: $authToken, createUserId: $createUserId, createdAt: $createdAt, currentPreferedHobby: $currentPreferedHobby, dob: $dob, emailId: $emailId, id: $id, lastUpdated: $lastUpdated, lastUpdatedBy: $lastUpdatedBy, mobile: $mobile, name: $name, userStatus: $userStatus)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.address == address &&
        other.authToken == authToken &&
        other.createUserId == createUserId &&
        other.createdAt == createdAt &&
        other.currentPreferedHobby == currentPreferedHobby &&
        other.dob == dob &&
        other.emailId == emailId &&
        other.id == id &&
        other.lastUpdated == lastUpdated &&
        other.lastUpdatedBy == lastUpdatedBy &&
        other.mobile == mobile &&
        other.name == name &&
        other.userStatus == userStatus;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        authToken.hashCode ^
        createUserId.hashCode ^
        createdAt.hashCode ^
        currentPreferedHobby.hashCode ^
        dob.hashCode ^
        emailId.hashCode ^
        id.hashCode ^
        lastUpdated.hashCode ^
        lastUpdatedBy.hashCode ^
        mobile.hashCode ^
        userStatus.hashCode ^
        name.hashCode;
  }
}

UserStatus _userStatusFromMap(String status) {
  switch (status) {
    case 'SIGNED_UP':
      return UserStatus.signedUp;

    case 'DEMO_BOOKED':
      return UserStatus.demoBooked;

    case 'COURSE_ENROLLED':
      return UserStatus.courseEnrolled;

    default:
      return UserStatus.signedUp;
  }
}

String _userStatusToMap(UserStatus status) {
  switch (status) {
    case UserStatus.signedUp:
      return 'SIGNED_UP';

    case UserStatus.demoBooked:
      return 'DEMO_BOOKED';

    case UserStatus.courseEnrolled:
      return 'COURSE_ENROLLED';

    default:
      return 'SIGNED_UP';
  }
}
