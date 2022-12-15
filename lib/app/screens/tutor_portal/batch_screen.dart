
// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/tutor_metrics.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/batch_card.dart';


class BatchScreen extends StatefulWidget {

  final data, index;

  const BatchScreen({Key? key, this.data, this.index}) : super(key: key);

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {

  dateConverter(date) {
    if(date == null) {
      return 'Null';
    }

    var newDate = '';

    newDate = '${DateTime.fromMicrosecondsSinceEpoch(date).day}'
        '-${DateTime.fromMicrosecondsSinceEpoch(date).month}'
        '-${DateTime.fromMicrosecondsSinceEpoch(date).year}';
    return newDate;
  }

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

  static const  headingStyle = TextStyle(
      fontSize: 26,
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins');



  static const  subHeadingStyle = TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins');


  List<BatchCard> studentList = <BatchCard>[
    const BatchCard(userData: '',),
    const BatchCard(userData: '',),
    const BatchCard(userData: '',),
  ];

  String numberOfStudents = '0';
  String completedSessions = '0';
  String assignedHomeworks = '0';
  late String courseStatus;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {

                numberOfStudents = widget.data['userIds'] !=null ? widget.data['userIds'].length.toString() : '0';
                completedSessions = widget.data['completedSessions'] !=null ? widget.data['completedSessions'].toString() : '0';
                assignedHomeworks = widget.data['assignedHomeworks'] != null ? widget.data['assignedHomeworks'].toString() : '0';
                courseStatus = widget.data['courseStatus'];

                if(!tutorPortalController.isLoading){
                  studentList = [];
                  if(widget.data['userIds'] != null){
                    for (var i = 0; i < widget.data['userIds'].length; i++) {
                      for (var j = 0; j < tutorPortalController.myStudents.length; j++) {
                        if (tutorPortalController.myStudents[i]['user']['id'] ==
                            widget.data['userIds'][i]) {
                          studentList.add(
                              BatchCard(userData: tutorPortalController.myStudents[i]));
                        }
                      }
                    }
                  }
                }
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
                            .height * 0.38,
                        color: const Color(0XFF0A5470),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [

                                IconButton(onPressed: () => Get.back, icon: const Icon(Icons.chevron_left, color: Colors.white,)),

                                Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.27),
                                  child: Text('Batch ${widget.index}',
                                    style: headingStyle,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: const [
                                    Text('Timing', style: subHeadingStyle,),
                                    Text('Students',style: subHeadingStyle ),
                                    Text('Sessions Completed',style: subHeadingStyle ),
                                    Text('Workouts Assigned',style: subHeadingStyle ),
                                    Text('Submission Pending',style: subHeadingStyle ),
                                    Text('Started On',style: subHeadingStyle ),
                                    Text('Status',style: subHeadingStyle ),

                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(':  Wed 4 PM & Sat 5 PM', style: subHeadingStyle,),
                                    Text(':  $numberOfStudents',style: subHeadingStyle),
                                    Text(':  $completedSessions',style: subHeadingStyle),
                                    Text(':  $assignedHomeworks',style: subHeadingStyle),
                                    const Text(':  8',style: subHeadingStyle),
                                    Text(':  ${dateConverter(1648799186199)}',style: subHeadingStyle),
                                    Text(':  $courseStatus',style: subHeadingStyle),

                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.54,
                      width: MediaQuery.of(context).size.width * 0.85,

                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: studentList.length,
                        itemBuilder: (BuildContext context, int index){
                          return studentList[index];
                        },
                      ),
                    ),


                  ],
                );
              }
          )
      ),
    );
  }

}

