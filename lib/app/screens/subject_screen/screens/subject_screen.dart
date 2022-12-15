// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../models/enums/subject.dart';
import '../../../utils/utils.dart';
import '../controllers/subject_screen_controller.dart';
import 'tutor_card.dart';

class SubjectScreen extends StatefulWidget {
  Subject subjects;
  SubjectScreen({
    Key? key,
    required this.subjects
  }) : super(key: key);

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectScreenController>(
        builder: (screenController){
          screenController
            ..getSubjects(widget.subjects)
            ..getAllTutorsEvent();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                capitalize(screenController.subject.name),
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(fontWeight: FontWeight.w500),),
              leading: CupertinoNavigationBarBackButton(
                color: ThemeColors.textDarkColor,
              ),
              elevation: 0,
            ),
            body:  Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: SafeArea(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Text(
                          Constants.ourTutors,
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                      if (screenController.tutors.isNotEmpty)
                        ...screenController.tutors
                            .map(
                              (tutor) => TutorCard(
                            isDemoAvailable:
                            !screenController.demoNotAvailable.contains(tutor.id),
                            tutor: tutor,
                            subject: screenController.subject,
                            isAlreadyBooked:
                            screenController.alreadyBookedTutor.contains(tutor.id),
                          ),
                        ).toList(),
                    ],
                  )),
            ),
          );
        }
    );
  }
}
