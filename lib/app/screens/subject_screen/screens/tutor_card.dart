import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../models/enums/subject.dart';
import '../../../models/tutors.dart';
import '../../../utils/utils.dart';
import '../../../widgets/star_rating_widget.dart';
import '../../../widgets/tutor_feature_pill.dart';
import '../../tutor_profile/tutor_profile_screen.dart';



class TutorCard extends StatefulWidget {
  final Tutor tutor;
  final Subject subject;
  final bool isDemoAvailable;
  final bool isAlreadyBooked;

  const TutorCard({
    Key? key,
    required this.tutor,
    required this.subject,
    required this.isDemoAvailable,
    required this.isAlreadyBooked,
  }) : super(key: key);

  @override
  State<TutorCard> createState() => _TutorCardState();
}

class _TutorCardState extends State<TutorCard> {
  String subjects = '';

  getTutorSubjects() {
    var subs = <String>[];
    widget.tutor.subjectsTaught?.forEach((element) {
      subs.add(capitalize(element.name));
    });

    subjects = subs.join(' , ');
  }

  @override
  void initState() {
    getTutorSubjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=> TutorProfileScreen(tutor: widget.tutor, subject: widget.subject, isDemoAvailable: widget.isDemoAvailable)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h, right: 3.w, left: 3.w),
        decoration: BoxDecoration(
          color: ThemeColors.white,
          border: Border.all(
            width: 1,
            color: ThemeColors.transparent,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.shadowColor.withOpacity(0.3),
              offset: const Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.w),
              child: Stack(
                children: [
                  SizedBox(
                    height: 225.h,
                    child: (widget.tutor.imageUrl!.contains('drive') ||
                            !widget.tutor.imageUrl!.startsWith('http'))
                        ? Image.asset(
                            Constants.tutorImagePath,
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.topCenter,
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.tutor.imageUrl!,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.topCenter,
                          ),
                  ),
                  Positioned(
                    top: 12.h,
                    left: 12.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.tutor.name ?? Constants.tutor,
                          style:
                              Theme.of(context).textTheme.headline5?.copyWith(
                                    color: ThemeColors.white,
                                  ),
                        ),
                        Text(
                          subjects,
                          style:
                              Theme.of(context).textTheme.subtitle1?.copyWith(
                                    color: ThemeColors.white,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    child: const TutorFeatureBar(),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 18.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StarRatingWidget(rating: widget.tutor.rating ?? 0),
                      Text(
                        '${widget.tutor.noOfSession?.toString() ?? '0'} Sessions',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  if (widget.isDemoAvailable)
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          RoutePaths.bookDemoWithSlotScreen,
                          arguments: {
                            'tutor': widget.tutor,
                            'subject': widget.subject,
                          },
                        );
                      },
                      child: Text(
                        Constants.bookDemo,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              color: ThemeColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150.w, 36.h),
                        primary: Theme.of(context).colorScheme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.w),
                        ),
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
