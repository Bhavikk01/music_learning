import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../data/controllers/course_controller.dart';
import '../../models/enums/subject.dart';
import '../../models/tutors.dart';
import '../../utils/utils.dart';
import '../../widgets/star_rating_widget.dart';
import '../../widgets/tutor_feature_pill.dart';
import 'about_tutor.dart';

class TutorProfileScreen extends StatefulWidget {
  const TutorProfileScreen({
    Key? key,
    required this.tutor,
    required this.subject,
    required this.isDemoAvailable,
  }) : super(key: key);
  final Tutor tutor;
  final Subject subject;
  final bool isDemoAvailable;

  @override
  State<TutorProfileScreen> createState() => _TutorProfileScreenState();
}

class _TutorProfileScreenState extends State<TutorProfileScreen> {
  bool isAlreadyBooked = false
  ;

  String subjects = '';

  getTutorSubjects() {
    var subs = <String>[];
    widget.tutor.subjectsTaught?.forEach((element) {
      subs.add(capitalize(element.name));
    });

    subjects = subs.join(' , ');
  }

  checkIfTutorAlreadyBooked() async {
    isAlreadyBooked =
        (await Get.find<CourseController>().getCourseBetweenUserAndTutor(widget.tutor.id!)).any(
            (course) =>
                (widget.tutor.subjectsTaught!.contains(course.subject) &&
                    widget.tutor.id == course.currentTutorId));

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getTutorSubjects();
    checkIfTutorAlreadyBooked();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.tutorProfile,
          style: Theme.of(context).textTheme.headline5,
        ),
        leading: CupertinoNavigationBarBackButton(
          color: ThemeColors.textDarkColor,
        ),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 16.h,
                ),
                ClipOval(
                  child: (widget.tutor.imageUrl!.contains('drive') ||
                          !widget.tutor.imageUrl!.startsWith('http'))
                      ? Image.asset(
                          Constants.tutorImagePath,
                          width: 80.w,
                          height: 80.w,
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.tutor.imageUrl!,
                          placeholder: (context, str) {
                            return Container(
                              child: Text(str),
                              color: Colors.red,
                            );
                          },
                          fit: BoxFit.cover,
                          width: 80.w,
                          height: 80.w,
                        ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.tutor.name ?? Constants.tutor,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          subjects,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 1.w,
                      color: ThemeColors.grey,
                    ),
                    Column(
                      children: [
                        StarRatingWidget(rating: widget.tutor.rating ?? 0),
                        Text(
                          '${widget.tutor.noOfSession?.toString() ?? '0'} Sessions',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Wrap(
                  runSpacing: 12.w,
                  children: [
                    TutorFeaturePill(
                      text: 'Hindi, English',
                      color: ThemeColors.grey,
                    ),
                    TutorFeaturePill(
                      text: 'Exp: 4 yrs',
                      color: ThemeColors.grey,
                    ),
                    TutorFeaturePill(
                      text: 'Students: 30',
                      color: ThemeColors.grey,
                    ),
                  ],
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  mainAxisAlignment: widget.isDemoAvailable
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.end,
                  children: [
                    if (widget.isDemoAvailable)
                      ElevatedButton(
                        onPressed: () => Get.toNamed(
                          RoutePaths.bookDemoWithSlotScreen,
                          arguments: {
                            'tutor': widget.tutor,
                            'subject': widget.subject,
                          },
                        ),
                        child: Text(
                          Constants.bookDemo,
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: ThemeColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.secondary,
                          minimumSize: Size(150.w, 36.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.w),
                          ),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () => Get.toNamed(
                        RoutePaths.buyCourse,
                        arguments: {
                          'tutor': widget.tutor,
                          'subject': widget.subject,
                        },
                      ),
                      child: Text(
                        isAlreadyBooked
                            ? Constants.rebuyCourse
                            : Constants.buyCourse,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ThemeColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: ThemeColors.buttonDarkColor,
                        minimumSize: Size(150.w, 36.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                      ),
                    ),
                  ],
                ),
                TutorDetailExpansionWidget(
                  tutor: widget.tutor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
