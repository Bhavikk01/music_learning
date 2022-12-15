
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/tutor_metrics.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/student_submission_card.dart';
import 'utils/toggle_button.dart';

class ManageSubmissionScreen extends StatefulWidget {
  const ManageSubmissionScreen({Key? key}) : super(key: key);

  @override
  State<ManageSubmissionScreen> createState() => _ManageSubmissionScreenState();
}

class _ManageSubmissionScreenState extends State<ManageSubmissionScreen> {

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

  var manageSubmissionValue = 'All';

  var manageSubmissionItem = ['All'];


  List<StudentSubmissionCard> manageSubmissionList = <StudentSubmissionCard>[];
  var toggleValue = 'Review Pending';


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {
                if(!tutorPortalController.isLoading){
                  manageSubmissionItem = ['All'];
                  for(var i = 0; i < tutorPortalController.myStudents.length; i++){
                    manageSubmissionItem
                        .add(tutorPortalController.myStudents[i]['user']['name']?? 'Student Name');
                  }
                  manageSubmissionList = [];
                  if(manageSubmissionValue == 'All') {
                    for(var i = 0; i < tutorPortalController.myStudents.length; i++){
                      for(var j = 0; j < tutorPortalController.myStudents[i]['allHomeworks'].length; j++) {
                        if(tutorPortalController.myStudents[i]['allHomeworks'][j]['state'] == 'IN_REVIEW'
                            && toggleValue == 'Review Pending') {

                          manageSubmissionList
                              .add(StudentSubmissionCard(
                              homeworkData: tutorPortalController.myStudents[i]['allHomeworks'][j],
                              userData: tutorPortalController.myStudents[i]));
                        } else if(tutorPortalController.myStudents[i]['allHomeworks'][j]['state'] == 'REVIEWED'
                            && toggleValue == 'Review Pending'){

                          manageSubmissionList
                              .add(StudentSubmissionCard(
                              homeworkData: tutorPortalController.myStudents[i]['allHomeworks'][j],
                              userData: tutorPortalController.myStudents[i]));
                        }
                      }
                    }
                  }
                  for(var i = 0; i < tutorPortalController.myStudents.length; i++) {
                    if(manageSubmissionValue == tutorPortalController.myStudents[i]['user']['name']){
                      for(var j = 0; j < tutorPortalController.myStudents[i]['allHomeworks'].length; j++) {
                        if(tutorPortalController.myStudents[i]['allHomeworks'][j]['state'] == 'IN_REVIEW'
                            && toggleValue == 'Review Pending') {

                          manageSubmissionList
                              .add(StudentSubmissionCard(
                              homeworkData: tutorPortalController.myStudents[i]['allHomeworks'][j],
                              userData: tutorPortalController.myStudents[i]));

                        } else if(tutorPortalController.myStudents[i]['allHomeworks'][j]['state'] == 'REVIEWED'
                            && toggleValue == 'Review Pending') {

                          manageSubmissionList
                              .add(StudentSubmissionCard(homeworkData: tutorPortalController.myStudents[i]['allHomeworks'][j],
                              userData: tutorPortalController.myStudents[i]));
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
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                                  child: Text('Manage Submissions',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )
                              ],
                            ),

                            Text('Select student/batch',
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
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(18.w, 0.h, 18.w, 0.h),
                                child: SizedBox(
                                  height: 42.h,
                                  child: DropdownButton(
                                    value: manageSubmissionValue,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    items: manageSubmissionItem.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp
                                          ),),
                                      );
                                    }).toList(),
                                    iconEnabledColor: Colors.grey,
                                    iconSize: 24,
                                    underline: Container(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        manageSubmissionValue = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    ),

                    Container(

                      height: MediaQuery.of(context).size.height * 0.61,
                      margin: EdgeInsets.only(top: 16.h, bottom: 16.w),
                      child: Column(
                        children: [
                          ToggleButton(titleOne: 'Review Pending', titleTwo: 'Reviewed', function1: () => {
                            setState(()=>{
                              toggleValue = 'Review Pending'

                            })
                          }, function2:  () => {
                            setState(()=>{
                              toggleValue = 'Reviewed'

                            })
                          },),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.53,
                            child:
                            manageSubmissionList.isEmpty ? Center(
                              child: Text('No Workouts Yet!', style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20.sp
                              ),),
                            ) :ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: manageSubmissionList.length,
                              itemBuilder: (BuildContext context, int index){
                                return manageSubmissionList[index];
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

