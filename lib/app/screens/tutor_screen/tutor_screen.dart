import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../data/controllers/tutor_controller.dart';
import '../../models/tutors.dart';
import 'tutor_card.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({Key? key}) : super(key: key);

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen> {
  List<Tutor> tutors = [];

  Future<void> getTutors() async {
    tutors = Get.find<TutorController>().getAllTutors();
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    getTutors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: tutors.isNotEmpty
            ? ListView(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    Constants.ourTutors,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ...tutors.map((tutor) => TutorCard(tutor: tutor)).toList()
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
