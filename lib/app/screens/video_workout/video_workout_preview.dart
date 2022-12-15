// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../constants/route_paths.dart';
import '../../data/controllers/workout_controller.dart';
import '../../widgets/main_button.dart';
import '../../widgets/workout_appbar.dart';


class VideoWorkoutPreview extends StatefulWidget {
  final String id;
  const VideoWorkoutPreview({required this.id, Key? key}) : super(key: key);

  @override
  State<VideoWorkoutPreview> createState() => _VideoWorkoutPreviewState();
}

class _VideoWorkoutPreviewState extends State<VideoWorkoutPreview> {

  late VideoPlayerController controller = VideoPlayerController.asset('');
  late final workoutBloc;

  @override
  void initState() {
    workoutBloc = Get.find<WorkoutController>();
    workoutBloc.fetchWorkoutEvent(widget.id).then((_) {
      if (!workoutBloc.loading && workoutBloc.workout != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {
            controller = VideoPlayerController.network('https://${workoutBloc.workout?.params?['Intro_video']??''}');
            controller.initialize().then((value) => controller.play());
          });
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkoutController>(
        builder: (workoutController){
    return Scaffold(
        appBar: WorkoutAppBar(
          title: workoutController.workout.workoutName??'',
          subTitle: workoutController.workout.params?['Subtitle']??'',
          context: context,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                  padding: const EdgeInsets.all(30),
                  child: VideoPlayer(controller)
              ),
            ),
            workoutController.loading
                ? const Center(child:SizedBox(width:50, height:50, child:CircularProgressIndicator()))
                : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child:Text(
                  workoutController.workout.params?['Description']??'helo there',
                  textAlign: TextAlign.center,)),

            Padding(padding: const EdgeInsets.all(20),
                // child: BlocBuilder<AudioBloc, AudioState>(
                //     builder: (BuildContext context, state) {
                //       final isRecording = state.recorderState == RecorderState.isRecording || state.recorderState == RecorderState.isRestarted;
                //       return
                child: MainButton(
                    isEnabled: true,//!workoutController.loading && workoutController.workout!=null,
                    title: 'Proceed', onPressed: () async {
                      await controller.pause();
                      await Get.toNamed(RoutePaths.videoWorkoutMain);
                })
            )
          ],
        )
    );});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
