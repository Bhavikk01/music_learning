import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Phone {
  Phone(this.phoneNumber);

  String phoneNumber;

  static bool validate(String phoneNumber) {
    return (int.tryParse(phoneNumber) != null) && phoneNumber.length == 10;
  }
}

class Email {
  Email(this.emailAddress);

  String emailAddress;

  static bool validate(String emailAddress, {bool allowEmpty = true}) {
    final validEmail = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");
    if (emailAddress != '') {
      return validEmail.hasMatch(emailAddress);
    }
    return allowEmpty;
  }
}

class Password {
  Password(this.password);

  String password;

  static bool validate(String password, {bool allowEmpty = false}) {
    if (password != '') {
      if (password.length >= 6) {
        return true;
      }
      return false;
    }
    return allowEmpty;
  }
}

String capitalize(String str) {
  return str.toUpperCase().substring(0, 1) + str.toLowerCase().substring(1);
}

Future<bool> onWillPop(
  DateTime currentBackPressTime,
  void Function() backPressUpdateCallBack,
  BuildContext context,
) {
  var now = DateTime.now();

  if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
    backPressUpdateCallBack();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Press back again to exit'),
        duration: Duration(seconds: 1),
      ),
    );
    return Future.value(false);
  }
  SystemNavigator.pop();
  return Future.value(true);
}

String getDayNameFromInt(int day) {
  switch (day) {
    case 1:
      return 'Monday';

    case 2:
      return 'Tuesday';

    case 3:
      return 'Wenesday';

    case 4:
      return 'Thursday';

    case 5:
      return 'Friday';

    case 6:
      return 'Saturday';

    case 7:
      return 'Sunday';

    default:
      return 'Sunday';
  }
}
