import 'package:flutter/material.dart';
import '../../config/colors.dart';

class CustomAccountTextField extends StatefulWidget {
  final String hintText;
  const CustomAccountTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<CustomAccountTextField> createState() => _CustomAccountTextFieldState();
}

class _CustomAccountTextFieldState extends State<CustomAccountTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        color: ThemeColors.milkyWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: Theme.of(context).textTheme.subtitle2,
        ),
      ),
    );
  }
}
