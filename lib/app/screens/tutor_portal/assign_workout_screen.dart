// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/route_paths.dart';
import '../../models/enums/workout_type.dart';
import '../../models/workout.dart';
import 'controllers/tutor_portal_controller.dart';
import 'utils/button.dart';

class AssignWorkoutScreen extends StatefulWidget {

  final data;

  const AssignWorkoutScreen({Key? key, this.data}) : super(key: key);

  @override
  State<AssignWorkoutScreen> createState() => _AssignWorkoutScreenState();
}

class _AssignWorkoutScreenState extends State<AssignWorkoutScreen> {

  @override
  void initState() {
    super.initState();
  }

  var workoutBankValue = 'All';

  int _value = 0;

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


  var toggleValue = 'All Workouts';

  compareWorkOutWithDropDown(WorkoutType? val) {

    switch (workoutTypeToString(val!)) {
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

  List<Workout> workoutBankList = <Workout>[];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          body: GetBuilder<TutorPortalController>(
              builder: (tutorPortalController) {
                log('Hello world');
                if(!tutorPortalController.isLoading) {
                  workoutBankList = [];
                  if(workoutBankValue == 'All') {
                    for (var i = 0; i < tutorPortalController.workoutBank.length; i++) {
                      workoutBankList
                          .add(tutorPortalController.workoutBank[i]);
                    }
                  }else {
                    for (var i = 0; i < tutorPortalController.workoutBank.length; i++) {

                      if (compareWorkOutWithDropDown(
                          tutorPortalController
                              .workoutBank[i].workoutSkeletonType)) {
                        workoutBankList
                            .add(tutorPortalController.workoutBank[i]);
                      }
                    }
                  }
                }
                log(workoutBankList.toString());
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
                            .height/4,
                        color: const Color(0XFF0A5470),
                        child: Column(
                          children: [

                            Row(
                              children: [
                                IconButton(onPressed: Get.back,
                                    icon: const Icon(Icons.chevron_left, color: Colors.white,)),
                                Container(
                                  margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.19),
                                  child: const Text('Assigning To',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )
                              ],
                            ),

                            Container(
                              padding: const EdgeInsets.only(top: 8, bottom: 32),
                              child:  Text(widget.data['user']['name']?? 'Student Name',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('Filter by workout type',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
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
                                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: SizedBox(
                                      height: 42,
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

                    Column(
                      children:  [
                        SizedBox(
                          height: MediaQuery.of(context).size.height/1.5,
                          child:
                          workoutBankList.isEmpty ? const Center(
                            child: Text('No Workouts assigned!', style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20
                            ),),
                          ) : MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: workoutBankList.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int i){
                                return ListTile(
                                  title: Text(
                                    workoutBankList[i].workoutName.toString(),
                                    style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.brown),
                                  ),
                                  leading: Radio(
                                    value: i,
                                    groupValue: _value,
                                    onChanged: (value) {
                                      setState(() {
                                        _value =
                                            int.parse(value.toString());
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ),
                        workoutBankList != []?
                        SizedBox(
                               child: Button(title: 'Proceed', function: () {
                                 Get.toNamed(
                                 RoutePaths.assignProceedingScreen,
                                 arguments: {
                                   'userData': widget.data,
                                   'homeworkData': workoutBankList[_value]
                                    }
                                 );
                               }),
                        ): Container(),
                      ],
                    )
                  ],
                );
              }
          )
      ),
    );
  }
}

