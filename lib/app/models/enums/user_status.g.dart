// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStatusAdapter extends TypeAdapter<UserStatus> {
  @override
  final int typeId = 2;

  @override
  UserStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserStatus.signedUp;
      case 1:
        return UserStatus.demoBooked;
      case 2:
        return UserStatus.courseEnrolled;
      default:
        return UserStatus.signedUp;
    }
  }

  @override
  void write(BinaryWriter writer, UserStatus obj) {
    switch (obj) {
      case UserStatus.signedUp:
        writer.writeByte(0);
        break;
      case UserStatus.demoBooked:
        writer.writeByte(1);
        break;
      case UserStatus.courseEnrolled:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
