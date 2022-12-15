import 'package:hive_flutter/hive_flutter.dart';

part 'user_status.g.dart';

@HiveType(typeId: 2)
enum UserStatus {
  @HiveField(0)
  signedUp,
  @HiveField(1)
  demoBooked,
  @HiveField(2)
  courseEnrolled,
}
