import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/route_paths.dart';
import '../../../models/enums/workout_type.dart';
import '../../../models/workout.dart';

class CardView extends StatelessWidget {

  final String title, id;
  final Workout workout;

  const CardView({
    Key? key, required this.title,
    required this.id,
    required this.workout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
          //Todo: Make the route dynamic
          onTap: () {
            if(workout.workoutSkeletonType == WorkoutType.customWorkoutSingleAudio){
              Get.toNamed(RoutePaths.tongueTwisterPreview,arguments: id);
            }else if(workout.workoutSkeletonType == WorkoutType.customVideoWorkout){
              Get.toNamed(RoutePaths.videoWorkoutPreview,arguments: id);
            }
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border:  Border.all(color: Colors.grey),
                boxShadow: [BoxShadow(
                    color: Colors.grey.shade300,
                    spreadRadius: 2
                )]
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            padding: const EdgeInsets.fromLTRB(10 , 16, 10, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'
                  ),),
                const Icon(Icons.chevron_right, color: Colors.black,)
              ],
            ),
          )
      ),
    );
  }
}

