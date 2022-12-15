
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:developer';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/route_paths.dart';
import '../../data/API/api_client.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/button.dart';

class AssignProceedingScreen extends StatefulWidget {

  final userData, homeworkData;

  const AssignProceedingScreen({Key? key, this.userData, this.homeworkData}) : super(key: key);

  @override
  State<AssignProceedingScreen> createState() => _AssignProceedingScreenState();
}

class _AssignProceedingScreenState extends State<AssignProceedingScreen> {


  @override
  void initState() {
    Get.find<TutorPortalController>();
    super.initState();
  }

  int? noOfSubmission;
  String? deadline;
  String? param1, param2;
  String? data;

  @override
  Widget build(BuildContext context) {

    final _api = ApiClient();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 32.h),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.2,
                          color: const Color(0XFF0A5470),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.chevron_left, color: Colors.white,)),
                                  Container(
                                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.19),
                                    child: Text(
                                      'Assigning To',
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
                                padding: EdgeInsets.only(top: 8.h, bottom: 32.w),
                                child: Text(widget.userData['user']['name']?? 'Student Name',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),

                            ],
                          )
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: Column(
                          children:  [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(32.w,0.h,32.h,0.w),
                                  child: const Text('Number of submissions require'),
                                ),
                                 Padding(
                                  padding: EdgeInsets.fromLTRB(32.w,4.h,32.w,0.h),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: const Color(0XFF0A5470)
                                    ),
                                    onChanged: (value) => noOfSubmission =  int.parse(value),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter a number',

                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(32.w,16.h,32.w,0.h),
                                  child: const Text('Select a deadline'),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(32.w,4.h,32.w,0.h),
                                  child: DateTimePicker(
                                    initialValue: '',
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: const Color(0XFF0A5470)
                                    ),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Enter a number',
                                    ),
                                    onChanged: (val) => deadline = val.toString(),
                                    validator: (val) {
                                      return null;
                                    },
                                    onSaved: (val) => log(val.toString()),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(32.w,16.h,32.w,0.h),
                                  child: const Text('Workout Parameter 1'),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(32.w,4.h,32.w,0.h),
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: const Color(0XFF0A5470)
                                    ),
                                    onChanged: (val) => param1 = val,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Param 1',

                                    ),
                                  ),
                                ),

                                const Padding(
                                  padding: EdgeInsets.fromLTRB(32,16,32,0),
                                  child: Text('Workout Parameter 2'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(32,4,32,0),
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        color: const Color(0XFF0A5470)
                                    ),
                                    onChanged: (val) => param2 = val,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Param 2',

                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Container(
                                margin: const EdgeInsets.only(top: 100),
                                child: Button(
                                  title: 'Proceed',
                                  //TODO: Here I have to improve the level of code
                                  function:  () async   {
                                     data = json.encode({
                                       'attemptedTime' : 0,
                                       'courseId': widget.userData['course']['id'],
                                       'createUserId': null,
                                       'createdAt': DateTime.now().millisecondsSinceEpoch,
                                       'deadlineTime': DateTime.parse(deadline!).millisecondsSinceEpoch,
                                       'lastUpdated': null,
                                       'lastUpdatedBy': null,
                                       'name': widget.homeworkData.workoutName,
                                       'noSubmissionsRequired': noOfSubmission,
                                       'state': 'ASSIGNED',
                                       'submissionValues': {
                                         'additionalProp1': param1,
                                         'additionalProp2': param2,
                                       },
                                       'teacherRemarks': null,
                                       'tutorId': '62dbb5208f680711424eef8f',
                                       'userId':  widget.userData['user']['id'],
                                       'workoutId': widget.homeworkData.id,
                                     });
                                     var res =  await _api.assignWorkoutToCourse(data);

                                     if(res.statusCode == 200) {
                                       await Get.toNamed(RoutePaths.workoutBookingSuccessScreen,
                                           arguments: widget.userData);
                                     }

                                    },
                                ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          )
      ),
    );
  }

}

