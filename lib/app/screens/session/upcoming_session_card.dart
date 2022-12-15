import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../data/controllers/tutor_controller.dart';
import '../../models/enums/subject.dart';
import '../../models/session.dart';
import '../../utils/utils.dart';

class UpcomingSessionCard extends StatefulWidget {
  final Session session;

  const UpcomingSessionCard({Key? key, required this.session})
      : super(key: key);

  @override
  State<UpcomingSessionCard> createState() => _UpcomingSessionCardState();
}

class _UpcomingSessionCardState extends State<UpcomingSessionCard> {
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
        'At $time $date with $tutorName (${capitalize(widget.session.subject?.name ?? '')})';
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.redAccent,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Cancelled',
                      ),
                    ),
                  ),
                  child: const Icon(Icons.close_rounded),
                ),
                Text(
                  Constants.cancel,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: ThemeColors.white),
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: DateTime.fromMillisecondsSinceEpoch(
                                    widget.session.startTime!)
                                .difference(DateTime.now()) >
                            const Duration(minutes: 5)
                        ? ThemeColors.grey
                        : Theme.of(context).colorScheme.secondary,
                    onSurface: ThemeColors.grey,
                    shape: const CircleBorder(),
                  ),
                  onPressed: () {
                    !widget.session.classRoom!.joiningLink!.startsWith('http')
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(Constants.invalidLink +
                                  widget.session.classRoom!.joiningLink!),
                            ),
                          )
                        : Get.toNamed(
                            RoutePaths.webviewScreen,
                            arguments: widget.session.classRoom!.joiningLink);
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                ),
                Text(
                  Constants.connect,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: ThemeColors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
