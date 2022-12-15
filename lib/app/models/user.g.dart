// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      address: fields[0] as Address?,
      authToken: fields[1] as String?,
      createUserId: fields[2] as String?,
      createdAt: fields[3] as int?,
      currentPreferedHobby: fields[4] as String?,
      dob: fields[5] as int?,
      emailId: fields[6] as String?,
      id: fields[7] as String?,
      lastUpdated: fields[8] as int?,
      lastUpdatedBy: fields[9] as String?,
      mobile: fields[10] as String,
      name: fields[11] as String?,
      userStatus: fields[12] as UserStatus,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.address)
      ..writeByte(1)
      ..write(obj.authToken)
      ..writeByte(2)
      ..write(obj.createUserId)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.currentPreferedHobby)
      ..writeByte(5)
      ..write(obj.dob)
      ..writeByte(6)
      ..write(obj.emailId)
      ..writeByte(7)
      ..write(obj.id)
      ..writeByte(8)
      ..write(obj.lastUpdated)
      ..writeByte(9)
      ..write(obj.lastUpdatedBy)
      ..writeByte(10)
      ..write(obj.mobile)
      ..writeByte(11)
      ..write(obj.name)
      ..writeByte(12)
      ..write(obj.userStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
