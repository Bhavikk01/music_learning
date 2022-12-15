// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/route_paths.dart';
import '../../data/controllers/workout_controller.dart';
import '../../widgets/main_button.dart';
import '../../widgets/workout_appbar.dart';


class VideoWorkoutMain extends StatefulWidget {
  const VideoWorkoutMain({Key? key}) : super(key: key);

  @override
  State<VideoWorkoutMain> createState() => _VideoWorkoutMainState();
}

class _VideoWorkoutMainState extends State<VideoWorkoutMain> {
  late final workoutBloc;

  @override
  void initState() {
    workoutBloc = Get.find<WorkoutController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkoutController>(
        builder: (workoutController){
          log(workoutController.workout.params?['workoutResource']?? 'this is the null'.toString());
          return Scaffold(
        appBar: WorkoutAppBar(
          title: workoutController.workout.workoutName??'',
          subTitle: workoutController.workout.params?['Subtitle']??'',
          context: context,
        ),

        body: Column(
          children: [
            Expanded(
                child: CachedNetworkImage(imageUrl: 'https://${workoutController.workout.params?['workoutResource']??''}'),
                // workoutstate.error==null
                //     ? workoutstate.loading
                //     ? const Center(child:SizedBox(width:50, height:50, child:CircularProgressIndicator()))
                //     : Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),child:Text(workoutstate.workout?.params?['Description']??'', textAlign: TextAlign.center,))
                //     : const Text('Something went wrong')
            ),
            Padding(padding: const EdgeInsets.all(20),
                // child: BlocBuilder<AudioBloc, AudioState>(
                //     builder: (BuildContext context, state) {
                //       final isRecording = state.recorderState == RecorderState.isRecording || state.recorderState == RecorderState.isRestarted;
                //       return
                      child: MainButton(
                        isEnabled: true,//!workoutstate.loading&&workoutstate.workout!=null,
                        title: 'Attempt this workout', onPressed: () async {
                          await Get.toNamed(RoutePaths.videoWorkoutCamera);
                      })
            )
          ],
        )
    );});
  }
}
