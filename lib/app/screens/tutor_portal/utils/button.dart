// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String title;
  final function;

  const Button({
    Key? key, required this.title, required this.function
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {function()},
        style: ButtonStyle(

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),)),
            backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xff0A5470))
        ),
        child:  Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: 'Poppins',
            ),),
        ));
  }
}
