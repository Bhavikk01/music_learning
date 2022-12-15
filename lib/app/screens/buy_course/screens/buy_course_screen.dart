import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../models/enums/pricing_plan.dart';
import '../../../models/enums/subject.dart';
import '../../../models/tutors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/large_book_button.dart';
import '../controllers/buy_course_controller.dart';
import '../widgets/course_details.dart';
import '../widgets/pricing_tile.dart';

class BuyCourseScreen extends StatefulWidget {
  final Tutor tutor;
  final Subject subject;
  const BuyCourseScreen({
    Key? key,
    required this.tutor,
    required this.subject,
  }) : super(key: key);

  @override
  State<BuyCourseScreen> createState() => _BuyCourseScreenState();
}

class _BuyCourseScreenState extends State<BuyCourseScreen> {

  loadAttribute() {
    Get.find<BuyCourseController>().getAttributes(
        widget.tutor,
        widget.subject,
        PricingPlan.alaCarte4,
        false
    );
  }

  @override
  void initState(){
    loadAttribute();
    Future.delayed(Duration.zero, () {
      if(Get.find<BuyCourseController>().courseFailed){
        log('Here getting success');
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              content: SizedBox(
                height: 200.h,
                child: Center(
                  child: Text(
                    Constants.buyCourseConfirmation,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context)
                        .colorScheme
                        .secondary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 36.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12.w),
                    ),
                  ),
                  onPressed: () => Get.toNamed(
                    RoutePaths.homePage,
                    arguments: 1,
                  ),
                  child: const Text('Continue'),
                ),
              ],
            );
          },
        );
      }
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<BuyCourseController> (
        builder: (buyCourseController) {
          Future.delayed(Duration.zero, () {
            if(Get.find<BuyCourseController>().courseSuccess){
              log('Here getting success');
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    content: SizedBox(
                      height: 200.h,
                      child: Center(
                        child: Text(
                          Constants.buyCourseConfirmation,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context)
                              .colorScheme
                              .secondary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 36.w,
                            vertical: 8.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(12.w),
                          ),
                        ),
                        onPressed: () => Get.toNamed(
                          RoutePaths.homePage,
                          arguments: 1,
                        ),
                        child: const Text('Continue'),
                      ),
                    ],
                  );
                },
              );
            }
          },);
      return Scaffold(
        appBar: AppBar(
          leading: CupertinoNavigationBarBackButton(
            color: ThemeColors.textDarkColor,
          ),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 36.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Constants.course,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            capitalize(widget.subject.name),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Constants.teacher,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            capitalize(widget.tutor.name!),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      const PricingTile(
                        pricingPlan: PricingPlan.alaCarte4,
                      ),
                      const PricingTile(
                        pricingPlan: PricingPlan.subscription4,
                      ),
                      const PricingTile(
                        pricingPlan: PricingPlan.alaCarte8,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Divider(
                        thickness: 2,
                        color: ThemeColors.shadowColor.withOpacity(0.4),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      CourseDetails(
                        plan: buyCourseController.plan,
                      ),
                      SizedBox(
                        height: 48.h,
                      ),
                      if (!buyCourseController.isTutorBooked)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: LargeBookButton(
                            title: buyCourseController.isTutorBooked
                                ? Constants.rebuyCourse
                                : Constants.buyCourse,
                            onTap: () async {
                              await buyCourseController.buyCourse();
                            }
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
            if (buyCourseController.loading)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        )
      );
    });
  }
}
