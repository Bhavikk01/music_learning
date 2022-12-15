import 'package:flutter/material.dart';
import '../config/colors.dart';
import '../constants/constants.dart';

class MainButton extends StatelessWidget {

  const MainButton({Key? key, required this.title, this.onPressed, this.isMain=true, this.isEnabled=true}) : super(key: key);
  final String title;
  final Function()? onPressed;
  final bool isMain;
  final bool isEnabled;

@override
  Widget build(BuildContext context) {
  return InkWell(
    borderRadius: BorderRadius.circular(25),
    onTap: isEnabled?onPressed:null,
    child: Container(
    height: 50,
    decoration: BoxDecoration(
      color: isMain ? Constants.themePrimary : ThemeColors.white,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: isMain ? Constants.themePrimary : const Color(0x33000000))
    ),
    child:  Center(child:
      Text(title, style: Theme
          .of(context)
          .textTheme
          .bodyText2?.copyWith(color: isMain ? Colors.white : Constants.themePrimary ),),),
    ),
  );
}
}