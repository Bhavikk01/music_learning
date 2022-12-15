import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../constants/route_paths.dart';

class UtilityCard extends StatelessWidget {
  final String imgPath;
  final String url;
  const UtilityCard({Key? key, required this.imgPath, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: ThemeColors.grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GestureDetector(
          onTap: () => Get.toNamed(
                RoutePaths.webviewScreen,
                arguments: url,
              ),

          child: Image.asset(imgPath)),
    );
  }
}
