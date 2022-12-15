
import 'package:flutter/material.dart';


class TutorToolWidget extends StatelessWidget {

  final String imageUrl, titleString, subTitle;
  final Color subTitleColor;
  // ignore: prefer_typing_uninitialized_variables
  final route;


  const TutorToolWidget({
    Key? key, required this.imageUrl, required this.titleString, required this.subTitle, required this.subTitleColor,required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          iconSize: 80,
          splashRadius: 40,
          disabledColor: Colors.grey,
          icon: Image.asset(imageUrl),
          onPressed: () => {
            route()
          },
        ),
        Text(titleString,
          style: const TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),),

        Text(subTitle,
          style: TextStyle(
              fontSize: 11,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              color: subTitleColor
          ),)
      ],
    );
  }
}