import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../models/tutors.dart';
import '../../utils/utils.dart';
import '../../widgets/star_rating_widget.dart';

class TutorCard extends StatefulWidget {
  final Tutor tutor;
  const TutorCard({Key? key, required this.tutor}) : super(key: key);

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
      onTap: () => Get.toNamed(
        RoutePaths.tutorProfileScreen,
        arguments: widget.tutor,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        height: 215.h,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 155.h,
                  margin: EdgeInsets.symmetric(vertical: 5.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.w),

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
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.topCenter,
                          ),
                    // child: Image.asset(
                    //   Constants.tutorImagePath,
                    //   fit: BoxFit.fitWidth,
                    //   width: MediaQuery.of(context).size.width,
                    //   alignment: Alignment.topCenter,
                    // ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.tutor.name}',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ThemeColors.white,
                            ),
                      ),
                      Text(
                        subjects,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: ThemeColors.white,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: StarRatingWidget(rating: widget.tutor.rating ?? 0)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                '${widget.tutor.noOfSession?.toString() ?? '0'} Sessions',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
