import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

import '../constants/constants.dart';
import '../models/user.dart';

class DataBaseRepository {
  static Future<void> saveUserData(User user) async {
    log('Here is the user: $user');
    await Hive.box(Constants.hiveUserDatabase).clear();

    await Hive.box(Constants.hiveUserDatabase).add(user);
    log('saved User');
  }

  static updateUserData(User user) {
    user.save();
  }

  static Future<void> deleteUserData(User user) async {
    await user.delete();
    await Hive.box(Constants.hiveUserDatabase).clear();
  }

  static User getUser() {
    final user = Hive.box(Constants.hiveUserDatabase).getAt(0);
    return user;
  }
}
