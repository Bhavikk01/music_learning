// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/route_paths.dart';
import '../../models/tutor_metrics.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/student_min_card.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({Key? key}) : super(key: key);

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {

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


  var MyStudentsList = <StudentMinimumCard>[];


  @override
  Widget build(BuildContext context) {



    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {

                if(!tutorPortalController.isLoading){
                  MyStudentsList = [];
                  for(var i = 0; i < tutorPortalController.myStudents.length; i++){
                      MyStudentsList
                          .add(
                          StudentMinimumCard(
                              data: tutorPortalController.myStudents[i],
                              function: () =>
                                  Get.toNamed(RoutePaths.reviewStudentScreen,
                                      arguments: tutorPortalController.myStudents[i])
                          ));
                  }
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.18,
                        color: const Color(0XFF0A5470),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                IconButton(onPressed: () => Navigator.pop(context),
                                    icon: const Icon(Icons.chevron_left, color: Colors.white,)),
                                Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.217),
                                  child: Column(
                                    children: const [
                                      Text('My Students',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Text('Select student/batch',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        )
                    ),


                    Container(

                      height: MediaQuery.of(context).size.height * 0.7,
                      margin: EdgeInsets.only(bottom: 16.h),
                      child: MyStudentsList.isEmpty ? Center(
                        child: Text('No Students Yet!', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp
                        ),
                        ),
                      ) : Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,

                            height: MediaQuery.of(context).size.height * 0.7,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: MyStudentsList.length,
                              itemBuilder: (BuildContext context, int index){
                                return MyStudentsList[index];
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
