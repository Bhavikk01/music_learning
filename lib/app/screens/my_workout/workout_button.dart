import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../widgets/outlined_button.dart' as custom;


class WorkoutButton extends custom.OutlinedButton {
  WorkoutButton({Key? key, required String title, TextStyle? style, Function()? onPressed})
      : super(key: key,
      onPressed: onPressed,
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    mainAxisSize: MainAxisSize.max,
    children: [
      Padding(padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(title, style: style)),
      Padding(padding: const EdgeInsets.symmetric(vertical: 10),
          child: Image.asset(Constants.chevronUp, height: 25,))
    ],
  ));

}
