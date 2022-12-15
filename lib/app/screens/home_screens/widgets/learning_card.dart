
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../data/controllers/tutor_controller.dart';
import '../../../models/course.dart';
import '../../../models/enums/learning_card_type.dart';
import '../../../models/enums/subject.dart';
import '../../../models/homework.dart';
import '../../../models/session.dart';
import '../../../utils/utils.dart';

class LearningCard extends StatefulWidget {
  final LearningCardType learningCardType;
  late final String title;
  final void Function()? ratingCallBack;
  final List<dynamic>? data;

  LearningCard({
    Key? key,
    required this.learningCardType,
    this.data,
    this.ratingCallBack,
  })  : assert(
          (learningCardType != LearningCardType.rating)
              ? (data != null) &&
                  (data is List<Session> ||
                      data is List<HomeWork> ||
                      data is List<Course>)
              : true,
        ),
        super(key: key) {
    title = Constants.learningCardTitles[learningCardType]!;
  }

  @override
  State<LearningCard> createState() => _LearningCardState();
}

class _LearningCardState extends State<LearningCard> {
  String body = '';
  Session? firstUpcomingSession;

  Future<void> getBody() async {
    switch (widget.learningCardType) {
      case LearningCardType.rating:
        body = Constants.learningCardBody[widget.learningCardType]!;
        break;

      case LearningCardType.session:
        if (widget.data!.isNotEmpty) {
          var firstSession = (widget.data as List<Session?>).firstWhereOrNull(
            (session) =>
                session!.startTime! > DateTime.now().millisecondsSinceEpoch,
          );

          if (firstSession == null) {
            body = Constants.learningCardBody[widget.learningCardType]!;
            return;
          }

          firstUpcomingSession = firstSession;
          var tutorId = firstSession.tutorId!;

          var tutorName = (await TutorController(tutorRepo: Get.find()).getAllTutors())
              .firstWhere((element) => element.id == tutorId)
              .name;
          var time = DateFormat.jm().format(
            DateTime.fromMillisecondsSinceEpoch(firstSession.startTime!),
          );

          body =
              'You have upcoming ${capitalize(firstSession.subject?.name ?? 'Vocal')} session with $tutorName at $time';
        } else {
          body = Constants.learningCardBody[widget.learningCardType]!;
        }
        break;

      case LearningCardType.workout:
        if (widget.data!.isNotEmpty) {
          body = 'You have ${widget.data!.length} new workouts';
        } else {
          body = Constants.learningCardBody[widget.learningCardType]!;
        }
        break;

      case LearningCardType.course:
        body = Constants.learningCardBody[widget.learningCardType]!;
        break;
      default:
    }

    if (mounted) setState(() {});
  }

  Function()? onPressed(context) {
    switch (widget.learningCardType) {
      case LearningCardType.session:
        return () => Get.toNamed(
          RoutePaths.sessionScreen,
        );

      case LearningCardType.workout:
        return () => Get.toNamed(
          RoutePaths.workout,
          // arguments: widget.data,
        );

      case LearningCardType.course:
        return () => Get.toNamed(RoutePaths.myCourseScreen);

      default:
        return null;
    }
  }

  @override
  void initState() {
    getBody();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Constants.learningCardColors[widget.learningCardType],
            borderRadius: BorderRadius.circular(12.w),
          ),
          child: Column(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              if (body != '')
                SizedBox(
                  height: 8.h,
                ),
              if (body != '')
                Text(
                  body,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontSize: 14.sp),
                ),
              if (body != '')
                SizedBox(
                  height: 12.h,
                ),
              if (widget.learningCardType == LearningCardType.rating)
                const RatingButtons(),
              if (widget.learningCardType == LearningCardType.session &&
                  (widget.data!.isNotEmpty) &&
                  body != Constants.learningCardBody[widget.learningCardType])
                SessionButton(
                  sessionLink: firstUpcomingSession!.classRoom!.joiningLink!,
                ),
              if (widget.learningCardType == LearningCardType.course)
                CourseButton(
                  courses: widget.data as List<Course>,
                ),
            ],
          ),
        ),
        widget.learningCardType == LearningCardType.session &&
                firstUpcomingSession != null
            ? Positioned(
                child: SvgPicture.asset(
                  Constants.learningSessionIcons[
                          firstUpcomingSession?.subject] ??
                      Constants.learningSessionIcons[Subject.guitar]!,
                  height: 20.h,
                ),
                left: 48.w,
                top: 20.h,
              )
            : Container(),
        widget.learningCardType == LearningCardType.rating
            ? Positioned(
                child: IconButton(
                  onPressed: widget.ratingCallBack,
                  icon: const Icon(Icons.close),
                  color: ThemeColors.darkColor,
                  iconSize: 18.w,
                ),
                right: 16.w,
                top: 4.h,
              )
            : Positioned(
                child: (widget.learningCardType == LearningCardType.course)
                    ? Container()
                    : TextButton(
                        onPressed: onPressed(context),
                        child: Text(
                          '${Constants.viewAll} >',
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                right: 20.w,
                top: 8.h,
              ),
      ],
    );
  }
}

class RatingButtons extends StatelessWidget {
  const RatingButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ThemeColors.white,
            minimumSize: Size(120.w, 30.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w),
            ),
          ),
          onPressed: () {},
          child: Text(
            Constants.leaveFeedback,
            style: Theme.of(context).textTheme.button,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ThemeColors.buttonDarkColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w),
            ),
            minimumSize: Size(120.w, 30.h),
          ),
          onPressed: () {},
          child: Text(
            Constants.rateUs,
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: ThemeColors.white,
                ),
          ),
        ),
      ],
    );
  }
}

class SessionButton extends StatelessWidget {
  final String sessionLink;
  const SessionButton({Key? key, required this.sessionLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ThemeColors.grey,
            minimumSize: Size(120.w, 30.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w),
            ),
          ),
          onPressed: () {
            Get.toNamed(
              RoutePaths.webviewScreen,
              arguments: sessionLink,
            );
          },
          child: Text(
            Constants.connect,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: ThemeColors.white),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: ThemeColors.white,
            minimumSize: Size(120.w, 30.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.w),
            ),
          ),
          onPressed: () {},
          child: Text(
            Constants.reschedule,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: ThemeColors.textPrimaryColor),
          ),
        ),
      ],
    );
  }
}

class CourseButton extends StatelessWidget {
  final List<Course> courses;
  const CourseButton({
    Key? key,
    required this.courses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ThemeColors.white,
        minimumSize: Size(120.w, 30.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        ),
      ),
      onPressed: () => Get.toNamed(RoutePaths.myCourseScreen),
      child: Text(
        Constants.viewAllCourses,
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: ThemeColors.textPrimaryColor),
      ),
    );
  }
}
