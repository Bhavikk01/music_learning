
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/enums/course_status.dart';
import '../../models/enums/course_type.dart';
import '../../models/tutor_metrics.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/card_batch.dart';
import 'utils/toggle_button.dart';

class MyBatchesScreen extends StatefulWidget {
  const MyBatchesScreen({Key? key}) : super(key: key);

  @override
  State<MyBatchesScreen> createState() => _MyBatchesScreenState();
}

class _MyBatchesScreenState extends State<MyBatchesScreen> {

  loadTutorPortalData() async {
    Get.find<TutorPortalController>()
      ..getAllAttribute(isLoading: true,
          tutorMetrics: const TutorMetrics(),
          homeworks: [],
          studentsWorkout: [],
          workoutBank: [],
          myStudents: [],
          myCourse: [])
      ..getAllTutorPortalData();
  }

  @override
  void initState() {
    loadTutorPortalData();
    super.initState();
  }

  List<CardWorkoutBank> myBatchesList = <CardWorkoutBank>[];
  var toggleValue = 'Active';


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {
                if(!tutorPortalController.isLoading){
                  myBatchesList = [];

                  if(toggleValue == 'Active') {
                    for (var i = 0; i < tutorPortalController.myCourse.length; i++) {
                      if (tutorPortalController.myCourse[i]['courseStatus'] == 'ACTIVE') {
                        myBatchesList
                            .add(CardWorkoutBank(
                          data: tutorPortalController.myCourse[i],
                          index: i + 1,));
                      }
                    }
                  }else if(toggleValue == 'Inactive'){
                    for (var i = 0; i < tutorPortalController.myCourse.length; i++) {
                      if (tutorPortalController.myCourse[i]['courseStatus'] != 'ACTIVE') {
                        myBatchesList
                            .add(CardWorkoutBank(
                            data: tutorPortalController.myCourse[i],
                            index: i + 1));
                      }
                    }
                  }
                }

                // Todo uncomment when the course is fixed
                // if(tutorPortalController.isLoading == false){
                //   tutorPortalController.myCourse.map((course) => {
                //       if(toggleValue == 'Active'){
                //         if(course.courseType == CourseType.batch && course.courseStatus == CourseStatus.active){
                //           myBatchesList
                //               .add(CardWorkoutBank(
                //               title: course.name.toString(),
                //               id: course.id.toString()))
                //         }
                //       }else if(toggleValue == 'Inactive') {
                //         if(course.courseType == CourseType.batch && course.courseStatus != CourseStatus.active){
                //           myBatchesList
                //               .add(CardWorkoutBank(
                //               title: course.name.toString(),
                //               id: course.id.toString()))
                //         }
                //       }
                //   }) ;
                // }

                return Column(
                  children: [
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.275,
                        color: const Color(0XFF0A5470),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.chevron_left, color: Colors.white,)),
                                Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.217),
                                  child: Text('My Batches',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )
                              ],
                            ),

                            ToggleButton(titleOne: 'Active', titleTwo: 'Inactive', function1: () => {
                              setState(()=>{
                                toggleValue = 'Active'

                              })
                            }, function2:  () => {
                              setState(()=>{
                                toggleValue = 'Inactive'

                              })
                            },),
                          ],
                        )
                    ),

                    Container(

                      height: MediaQuery.of(context).size.height * 0.62,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: myBatchesList.isEmpty ? Center(
                        child: Text('No Batches Yet!', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp
                          ),
                        ),
                      ) : Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.62,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: myBatchesList.length,
                              itemBuilder: (BuildContext context, int index){
                                return myBatchesList[index];
                              },
                            ),
                          ),

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

