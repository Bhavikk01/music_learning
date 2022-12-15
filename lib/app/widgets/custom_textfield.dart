import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../config/colors.dart';
import '../constants/constants.dart';
import '../constants/route_paths.dart';


class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextInputType inputType;
  final bool showForgot;
  final TextStyle? style;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.inputType,
    this.style,
    this.onChanged,
    this.showForgot = true,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller
      ..clear()
      ..dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50.h,
      decoration: BoxDecoration(
        color: ThemeColors.white,
        border: Border.all(
          width: 1,
          color: ThemeColors.transparent,
        ),
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.shadowColor.withOpacity(0.3),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        style: Theme.of(context).textTheme.bodyText1,
        keyboardType: widget.inputType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: widget.style ?? Theme.of(context).textTheme.subtitle2,
          suffixIcon: (widget.inputType == TextInputType.visiblePassword &&
                  widget.showForgot)
              ? TextButton(
                  onPressed: () => Get.toNamed(
                    RoutePaths.forgotPasswordScreen,
                  ),
                  style: TextButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '${Constants.forgot}?',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        ?.copyWith(color: ThemeColors.textLightColor),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
