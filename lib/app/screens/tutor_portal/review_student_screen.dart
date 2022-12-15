
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/route_paths.dart';
import 'assign_workout_screen.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/button.dart';
import 'utils/review_student_card.dart';

class ReviewStudentScreen extends StatefulWidget {

  final data;

  const ReviewStudentScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ReviewStudentScreen> createState() => _ReviewStudentScreenState();
}

class _ReviewStudentScreenState extends State<ReviewStudentScreen> {


  @override
  void initState() {
    super.initState();
  }

  compareWorkOutWithDropDown(String? val) {

    switch (val) {
      case 'PITCH_MATCHING_1':
        return 'Pitch Matching' == workoutBankValue;
      case 'Q_AND_A':
        return 'Question Answers' == workoutBankValue;
      case 'EAR_TRAINING_1':
        return 'Ear Training' == workoutBankValue;
      case 'CUSTOM_WORKOUT_SINGLE_AUDIO':
        return 'Audio Training' == workoutBankValue;
      case 'CUSTOM_VIDEO_WORKOUT':
        return 'Video Training' == workoutBankValue;
      case 'MT_QUIZ_1':
        return 'MT Quiz' == workoutBankValue;
      case 'SC_1':
        return 'SC' == workoutBankValue;
      default:
        return false;
    }
  }

  var workoutBankValue = 'All';

  var workoutBankItem = [
    'All',
    'Pitch Matching',
    'Question Answers',
    'Ear Training',
    'Audio Training',
    'Video Training',
    'MT Quiz',
    'SC'
  ];

  List<ReviewStudentCard> workoutBankList = <ReviewStudentCard>[];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {

                if(!tutorPortalController.isLoading){
                  workoutBankList = [];

                  if(workoutBankValue == 'All'){
                    for(var i = 0; i < widget.data['allHomeworks'].length; i++){
                        workoutBankList.add(ReviewStudentCard(
                            data: widget.data['allHomeworks'][i]));
                    }
                  }else{
                    for(var i = 0; i < widget.data['allHomeworks'].length; i++){
                      if(compareWorkOutWithDropDown(widget.data['allHomeworks'][i]['workoutSkeletonType'])) {
                        workoutBankList.add(ReviewStudentCard(
                            data: widget.data['allHomeworks'][i]));
                      }
                    }
                  }

                }

                return Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 32),
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.26,
                        color: const Color(0XFF0A5470),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed: () => Get.back,
                                    icon: const Icon(Icons.chevron_left, color: Colors.white,)),
                                Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
                                  child: Text('Workout Assigned To',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )
                              ],
                            ),

                            Container(
                              padding: const EdgeInsets.only(top: 8, bottom: 32),
                              child:  Text(widget.data['user']['name']?? 'Student Name',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Filter by workout type',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                                    child: SizedBox(
                                      height: 42.h,
                                      child: DropdownButton(
                                        value: workoutBankValue,
                                        icon: const Icon(Icons.arrow_drop_down),
                                        items: workoutBankItem.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Text(items,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16
                                              ),),
                                          );
                                        }).toList(),
                                        iconEnabledColor: Colors.grey,
                                        iconSize: 24,
                                        underline: Container(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            workoutBankValue = newValue!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),

                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      margin: const EdgeInsets.only(top: 8, bottom: 0),
                      child: Column(
                        children:  [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.545,
                            child:
                            workoutBankList.isEmpty ? Center(
                              child: Text('No Workouts assigned!', style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20.sp
                              ),),
                            ) :ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: workoutBankList.length,
                              itemBuilder: (BuildContext context, int index){
                                return workoutBankList[index];
                              },
                            ),
                          ),

                          Container(
                              margin: EdgeInsets.only(top: 16.h),
                              child: Button(title: 'Assign New Workout',
                                function: () =>
                                    Get.toNamed(RoutePaths.assignWorkoutScreen,
                                        arguments: widget.data)
                                )
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
          )
      ),
    );
  }

}

