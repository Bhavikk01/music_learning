
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../models/enums/workout_type.dart';
import '../../models/tutor_metrics.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/button.dart';
import 'utils/card.dart';
import 'utils/toggle_button.dart';

class WorkoutBankScreen extends StatefulWidget {
  const WorkoutBankScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutBankScreen> createState() => _WorkoutBankScreenState();
}

class _WorkoutBankScreenState extends State<WorkoutBankScreen> {

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

  var workoutBankList = [];
  var toggleValue = 'All Workouts';

  compareWorkOutWithDropDown(WorkoutType? val) {

      switch (workoutTypeToString(val)) {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {
                if(tutorPortalController.workoutBank.isNotEmpty){
                  workoutBankList = [];
                  if(toggleValue == 'All Workouts') {

                    if(workoutBankValue == 'All'){
                      for (var i =0; i < tutorPortalController.workoutBank.length; i++){
                          workoutBankList.add(CardView(
                            title: tutorPortalController.workoutBank[i].workoutName.toString(),
                            id: tutorPortalController.workoutBank[i].id.toString(),
                            workout: tutorPortalController.workoutBank[i]
                          ));

                      }
                    }else {
                      for (var i =0; i < tutorPortalController.workoutBank.length; i++){
                        if(compareWorkOutWithDropDown(tutorPortalController.workoutBank[i].workoutSkeletonType)){
                          workoutBankList.add(CardView(
                            title: tutorPortalController.workoutBank[i].workoutName.toString(),
                            id: tutorPortalController.workoutBank[i].id.toString(),
                            workout: tutorPortalController.workoutBank[i]
                          ));

                        }
                      }
                    }
                  }
                  else{
                    for (var i =0; i < tutorPortalController.workoutBank.length; i++){

                      // Todo: add this condition here in and item.tutorId == DataBaseRepository.getUser().id
                      if(compareWorkOutWithDropDown(tutorPortalController.workoutBank[i].workoutSkeletonType) ){
                        workoutBankList.add(CardView(
                          title: tutorPortalController.workoutBank[i].workoutName.toString(),
                          id: tutorPortalController.workoutBank[i].id.toString(),
                          workout: tutorPortalController.workoutBank[i]
                        ));
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
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
                                child: Text('Workout Bank',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600
                                  ),
                                ),
                              )
                            ],
                          ),
                          
                          Text('Select workout type',
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
                              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
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
                      )
                    ),

                    Container(

                      height: MediaQuery.of(context).size.height * 0.61,
                      margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                      child: Column(
                        children: [
                          ToggleButton(titleOne: 'All Workouts', titleTwo: 'My Workouts', function1: () => {
                            setState(()=>{
                              toggleValue = 'All Workouts'

                            })
                          }, function2:  () => {
                            setState(()=>{
                              toggleValue = 'My Workouts'

                            })
                          },),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.47,
                            child:
                            workoutBankList.isEmpty ? const Center(
                              child: Text('No Workouts Yet!', style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20
                              ),),
                            ) :ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: workoutBankList.length,
                              itemBuilder: (BuildContext context, int index){
                                return workoutBankList[index];
                              },
                            ),
                          ),

                          const Button(title: 'Create New Workout', function: null,)
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

