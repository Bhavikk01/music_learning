
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/route_paths.dart';
import '../../models/enums/workout_type.dart';
import '../../widgets/workout_appbar.dart';
import 'controllers/workout_homework_controller.dart';
import 'workout_button.dart';

class MyWorkout extends StatelessWidget {
  const MyWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<WorkOutHomeworkController>().fetchHomeWorkData();
    return Scaffold(
      appBar: WorkoutAppBar(title: 'My Workout', context: context),
      body: GetBuilder<WorkOutHomeworkController>(
      builder: (homeworkController) =>
      homeworkController.loading
          ? const CircularProgressIndicator()
          : homeworkController.homeworks!=null
            ? homeworkController.homeworks!.isEmpty
                ? const Center(child: Text('No homework assigned'),)
                : ListView.builder(
          padding: const EdgeInsets.only(top: 30),
          itemCount: homeworkController.homeworks!.length,
          itemBuilder: (context, index) {

            return WorkoutButton(title: homeworkController.homeworks![index].name!, style: Theme.of(context).textTheme.bodyText2, onPressed: (){Get.toNamed(routeMap[homeworkController.homeworks![index].workoutSkeletonType]!,arguments: homeworkController.homeworks![index].workoutId);},);
          }
      )
          :const Center(child:Text('Something went wrong')),
    ));
  }
}

final Map<WorkoutType, String> routeMap = {
  WorkoutType.customWorkoutSingleAudio: RoutePaths.tongueTwisterPreview,
  WorkoutType.customVideoWorkout: RoutePaths.videoWorkoutPreview,
  WorkoutType.qnA: RoutePaths.earTrainingIntroScreen,
  WorkoutType.earTraining: RoutePaths.earTrainingIntroScreen,
  WorkoutType.mtQuiz: RoutePaths.earTrainingIntroScreen,
  WorkoutType.pitchMatching: RoutePaths.earTrainingIntroScreen,
  WorkoutType.sc: RoutePaths.earTrainingIntroScreen,
};

