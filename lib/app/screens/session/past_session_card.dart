
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../data/controllers/tutor_controller.dart';
import '../../models/enums/subject.dart';
import '../../models/session.dart';
import '../../utils/utils.dart';

class PastSessionCard extends StatefulWidget {
  final Session session;
  const PastSessionCard({Key? key, required this.session}) : super(key: key);

  @override
  State<PastSessionCard> createState() => _PastSessionCardState();
}

class _PastSessionCardState extends State<PastSessionCard> {
  String body = '';

  Future<void> getBody() async {
    var tutorName = (await Get.find<TutorController>().getAllTutors())
        .firstWhere((element) => element.id == widget.session.tutorId)
        .name;
    var time = DateFormat.jm().format(
      DateTime.fromMillisecondsSinceEpoch(widget.session.startTime!),
    );
    var date = DateFormat('dd MMM yyyy').format(
      DateTime.fromMillisecondsSinceEpoch(widget.session.startTime!),
    );

    body =
        'Completed on $time $date with $tutorName (${capitalize(widget.session.subject?.name ?? '')})';
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getBody();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: ThemeColors.buttonDarkColor,
          borderRadius: BorderRadius.circular(12.w),
        ),
        width: 325.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        Constants
                                .learningSessionIcons[widget.session.subject] ??
                            Constants.learningSessionIcons[Subject.guitar]!,
                        height: 20.h,
                        color: ThemeColors.white,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Text(
                        widget.session.topic ??
                            Constants.mySessions.substring(3, 10),
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: ThemeColors.white,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    body,
                    softWrap: true,
                    style: Theme.of(context).textTheme.button?.copyWith(
                          color: ThemeColors.white,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                ),
                primary: Theme.of(context).colorScheme.secondary,
                onSurface: ThemeColors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.w),
                ),
              ),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'Recorded link is ${widget.session.classRoom?.joiningLink}'),
                ),
              ),
              child: const Text(
                Constants.viewRecording,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
