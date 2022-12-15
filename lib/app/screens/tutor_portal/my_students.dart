
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/tutor_metrics.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/students_card.dart';

class MyStudentsScreen extends StatefulWidget {
  const MyStudentsScreen({Key? key}) : super(key: key);

  @override
  State<MyStudentsScreen> createState() => _MyStudentsScreenState();
}

class _MyStudentsScreenState extends State<MyStudentsScreen> {

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

  late List<StudentsCard> myStudentsList = [];



  @override
  Widget build(BuildContext context) {





    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {
                if(!tutorPortalController.isLoading){
                  myStudentsList = [];
                  for(var i = 0; i < tutorPortalController.myStudents.length; i++) {
                    myStudentsList.add(StudentsCard(data: tutorPortalController.myStudents[i],));
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
                            .height * 0.13,
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
                                  child: const Text('My Students',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                    ),


                    Container(

                      height: MediaQuery.of(context).size.height * 0.76,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: myStudentsList.isEmpty ? Center(
                        child: Text('No Students Yet!', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20.sp
                        ),
                        ),
                      ) : Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,

                            height: MediaQuery.of(context).size.height * 0.76,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: myStudentsList.length,
                              itemBuilder: (BuildContext context, int index){
                                return myStudentsList[index];
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
