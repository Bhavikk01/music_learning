import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/route_paths.dart';
import '../../models/tutor_metrics.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/tutor_metrics.dart';
import 'utils/tutor_tool_widget.dart';

class TutorMainScreen extends StatefulWidget {
  const TutorMainScreen({Key? key}) : super(key: key);

  @override
  State<TutorMainScreen> createState() => _TutorMainScreenState();
}

class _TutorMainScreenState extends State<TutorMainScreen> {

  loadTutorPortalData() async {
    await Get.find<TutorPortalController>()
        .getAllAttribute(isLoading: true,
            tutorMetrics: const TutorMetrics(),
            homeworks: [],
            studentsWorkout: [],
            workoutBank: [],
            myStudents: [],
            myCourse: []);
        await Get.find<TutorPortalController>()
        .getAllTutorPortalData();
  }

  @override
  void initState() {
    setState(() {
      loadTutorPortalData();
      super.initState();
    });
  }
  int noWorkoutsAssigned = 0;
  int noReviewPending = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {

                if(tutorPortalController.isLoading){
                  Get.find<TutorPortalController>().getAllTutorPortalData();
                }

                if(!tutorPortalController.isLoading) {
                  noReviewPending = 0;
                  for(var i = 0; i < tutorPortalController.myStudents.length; i++){
                    for(var j = 0; j < tutorPortalController.myStudents[i]['allHomeworks'].length; j++) {
                      if(tutorPortalController.myStudents[i]['allHomeworks'][j]['state'] == 'IN_REVIEW' ) {
                        noReviewPending++;
                      }
                    }
                  }
                  noWorkoutsAssigned =0;
                  for(var i = 0; i < tutorPortalController.myStudents.length; i++) {
                     noWorkoutsAssigned += int.parse(tutorPortalController.myStudents[i]['allHomeworks'].length.toString()) ;
                  }
                }

                return tutorPortalController.isLoading == true && tutorPortalController.workoutBank.isEmpty
                    ? const Center(child: Text('Loading'))
                    :Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.27,
                      color: const Color(0XFF0A5470),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TutorMetric(value: tutorPortalController.tutorMetrics.studentsEnrolled
                              .toString(), type: 'Students enrolled'),
                          TutorMetric(
                              value: tutorPortalController.tutorMetrics.sessionsCompleted
                                  .toString(), type: 'Sessions completed'),
                          TutorMetric(value: tutorPortalController.tutorMetrics.workoutsAssigned
                              .toString(), type: 'Workouts assigned'),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        TutorToolWidget(
                          imageUrl: 'assets/images/review.png',
                          titleString: 'Review Submissions',
                          subTitle: '$noReviewPending reviews pending',
                          subTitleColor:noReviewPending == 0 ? Colors.green : Colors.red,
                          route: () => {
                            Get.toNamed(
                              RoutePaths.manageSubmissionScreen,
                            ),
                          }),
                        TutorToolWidget(
                          imageUrl: 'assets/images/studentWorkouts.png',
                          titleString: 'Student Workouts',
                          subTitle: '$noWorkoutsAssigned workouts assigned',
                          subTitleColor: Colors.green,
                          route: () => {
                            Get.toNamed(
                              RoutePaths.studentListScreen,
                            ),
                          }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:  [
                        TutorToolWidget(
                            imageUrl: 'assets/images/chat.png',
                            titleString: 'Chat',
                            subTitle: 'Coming Soon',
                            subTitleColor: Colors.green,
                            route: () => {}),
                        TutorToolWidget(
                            imageUrl: 'assets/images/workoutBank.png',
                            titleString: 'Workout Bank',
                            subTitle:  tutorPortalController.workoutBank.isEmpty ? '' : '${tutorPortalController.workoutBank.length} Workouts',
                            subTitleColor: Colors.green,
                            route: () => {
                              Get.toNamed(
                                RoutePaths.workoutBankScreen,
                              ),
                            }),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TutorToolWidget(
                            imageUrl: 'assets/images/myBatches.png',
                            titleString: 'My Batches',
                            subTitle: '',
                            subTitleColor: Colors.red,
                            route:() => {
                              Get.toNamed(
                                RoutePaths.myBatchesScreen,
                              ),
                            }),

                        TutorToolWidget(
                            imageUrl: 'assets/images/myStudents.png',
                            titleString: 'My Students',
                            subTitle: '',
                            subTitleColor: Colors.red,
                            route: () => {
                              Get.toNamed(
                                RoutePaths.myStudentsScreen,
                              ),
                            }),
                      ],
                    ),
                  ],
                );
              }
          )
      ),
    );
  }
}