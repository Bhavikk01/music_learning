
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../models/enums/pricing_plan.dart';
import '../controllers/buy_course_controller.dart';

class PricingTile extends StatelessWidget {
  final PricingPlan pricingPlan;
  const PricingTile({
    Key? key,
    required this.pricingPlan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BuyCourseController>(
      builder: (buyCourseController) {
        return Container(
          padding: EdgeInsets.only(right: 18.w),
          margin: EdgeInsets.only(bottom: 18.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.w),
            color: (buyCourseController.plan == pricingPlan)
                ? ThemeColors.buttonDarkColor
                : ThemeColors.white,
            boxShadow: [
              BoxShadow(
                color: ThemeColors.shadowColor.withOpacity(0.3),
                offset: const Offset(0, 4),
                blurRadius: 6,
              ),
            ],
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            minLeadingWidth: 0,
            title: Text(
              Constants.pricingTiles[pricingPlan]!['title'] as String,
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                fontWeight: FontWeight.w500,
                color: (buyCourseController.plan == pricingPlan)
                    ? ThemeColors.white
                    : ThemeColors.textPrimaryColor,
              ),
            ),
            leading: Radio<PricingPlan>(
              value: pricingPlan,
              groupValue: buyCourseController.plan,
              onChanged: (pricingPlan) => buyCourseController
                  .buyCourseChangePricingPlanEvent(pricingPlan!)),
            trailing: Text(
              '₹ ${Constants.pricingTiles[pricingPlan]!['price']}',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: (buyCourseController.plan == pricingPlan)
                    ? ThemeColors.white
                    : ThemeColors.textPrimaryColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
