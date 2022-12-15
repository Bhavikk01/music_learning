import 'package:flutter/material.dart';
import '../config/colors.dart';
import '../constants/constants.dart';

class WorkoutAppBar extends AppBar {

  WorkoutAppBar(
      {Key? key, required String title, String? subTitle, required BuildContext context})
      : super(key: key,
      backgroundColor: Constants.themePrimary,
      foregroundColor: ThemeColors.white,
      toolbarHeight: 112,
      centerTitle: true,
      title: subTitle==null ? Text(title, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white))
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
          Text(subTitle, style:Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
        ],)
  );
}