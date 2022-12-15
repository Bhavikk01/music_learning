import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../data/API/api_client.dart';
import '../../../models/enums/subject.dart';
import '../../../models/homework.dart';
import '../../../widgets/large_book_button.dart';



class EarTrainingIntroScreen extends StatefulWidget {
  final HomeWork homeWork;
  const EarTrainingIntroScreen({Key? key, required this.homeWork})
      : super(key: key);

  @override
  State<EarTrainingIntroScreen> createState() => _EarTrainingIntroScreenState();
}

class _EarTrainingIntroScreenState extends State<EarTrainingIntroScreen> {
  String tutorName = '';
  Subject sub = Subject.guitar;

  getData() async {
    var tutor = await ApiClient().getTutor(widget.homeWork.tutorId!);
    tutorName = tutor.name!;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Constants.myWorkouts),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                margin: EdgeInsets.only(top: 24.h),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 24, 77, 62),
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
                  children: [
                    Text(
                      'Assigned By $tutorName',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: ThemeColors.white),
                    ),
                    Text(
                      'On ${DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.homeWork.createdAt!))}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: ThemeColors.white),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      'You\'ve completed 0/1 submissions',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: ThemeColors.white),
                    ),
                    Text(
                      'Deadline: ${DateFormat('dd MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.homeWork.createdAt!).add(const Duration(days: 10)))}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: ThemeColors.white),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 12.w),
                margin: EdgeInsets.only(top: 24.h),
                decoration: BoxDecoration(
                  color: ThemeColors.milkyWhite,
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
                  children: [
                    Text(
                      'Quiz Description',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      'This quiz will test your ability to differentiate between higher and lower notes.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Text(
                      'Total Questions: 5',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      'Passing Score: 3',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Text(
                      'Reward: Avatar 1 + 10 Pickit Coins',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 36.h,
                    ),
                    Text(
                      'Please make sure your earphones are connected before playing the quiz.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 48.h,
              ),
              LargeBookButton(
                title: 'Play Now',
                onTap: () => Get.toNamed(RoutePaths.earTrainingScreen)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
