
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../data/controllers/sessions_controller.dart';
import '../../models/enums/session_status.dart';
import 'past_session_card.dart';
import 'upcoming_session_card.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  bool isFirstActive = true;
  List<dynamic> sessions = [];

  Future<void> getSessions() async {
    sessions = await Get.find<SessionController>().getAllSession();
    setState(() {});
  }

  @override
  void initState() {
    getSessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ThemeColors.buttonDarkColor,
          leading: BackButton(
            color: ThemeColors.white,
          ),
          centerTitle: true,
          title: Text(
            Constants.mySessions,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontSize: 28.sp,
                  color: ThemeColors.white,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text(
                Constants.filters,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: ThemeColors.textGreyColor,
                      offset: Offset(0.h, -5.w),
                    ),
                  ],
                  color: ThemeColors.transparent,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: ThemeColors.textModerateColor,
                  decorationThickness: 4.h,
                ),
              ),
            ),
          ],
          bottom: PreferredSize(
            child: Column(
              children: [
                TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3.h,
                  indicatorColor: ThemeColors.white,
                  tabs: [
                    Text(
                      Constants.upcoming,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: ThemeColors.white,
                            fontSize: 18.sp,
                          ),
                    ),
                    Text(
                      Constants.past,
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: ThemeColors.white,
                            fontSize: 18.sp,
                          ),
                    ),
                  ],
                ),
                const SessionTopWiget(),
              ],
            ),
            preferredSize: Size.fromHeight(110.h),
          ),
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: sessions.map((e) {
                    if (e.sessionStatus == SessionStatus.scheduled &&
                        e.startTime! >
                            (DateTime.now()).millisecondsSinceEpoch) {
                      return UpcomingSessionCard(session: e);
                    } else {
                      return Container();
                    }
                  }).toList(),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: sessions.map((e) {
                    if (e.startTime! < DateTime.now().millisecondsSinceEpoch) {
                      return PastSessionCard(session: e);
                    } else {
                      return Container();
                    }
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionTopWiget extends StatelessWidget {
  const SessionTopWiget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 70.h,
          color: ThemeColors.buttonDarkColor,
          padding: EdgeInsets.only(
            top: 18.h,
          ),
        ),
        Positioned(
          child: Container(
            width: 325.w,
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ThemeColors.grey),
              borderRadius: BorderRadius.circular(24.w),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Constants.searchSessions,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Icon(
                    Icons.search,
                    color: ThemeColors.grey,
                  ),
                ],
              ),
            ),
          ),
          top: 50.h,
        ),
      ],
    );
  }
}
