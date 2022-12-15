import 'package:flutter/material.dart';
import '../constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leadingWidth: 24,
      title: Image.asset(
        Constants.appLogoPath,
        height: 42,
      ),
      elevation: 0,
    );
  }
}
