// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../data/controllers/workout_controller.dart';
import '../../models/enums/recorder_state.dart';
import '../../widgets/main_button.dart';
import '../../widgets/workout_appbar.dart';
import 'controllers/video_controller.dart';


class VideoWorkoutRecording extends StatefulWidget {
  const VideoWorkoutRecording({Key? key}) : super(key: key);

  @override
  State<VideoWorkoutRecording> createState() => _VideoWorkoutRecordingState();
}

class _VideoWorkoutRecordingState extends State<VideoWorkoutRecording> {

  late final videoBloc;

  @override
  void initState() {
    videoBloc = Get.find<VideoController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<WorkoutController>();
    return GetBuilder<WorkoutController>(
        builder: (workoutController){
    return Scaffold(
        appBar: WorkoutAppBar(
          title: workoutController.workout.workoutName??'',
          subTitle: workoutController.workout.params?['Subtitle']??'',
          context: context,),
        body: Column(
          children: [
            Image.asset(Constants.rec, height: 50,),
            Expanded(
              child: CachedNetworkImage(imageUrl: 'https://${workoutController.workout.params?['workoutResource']??''}'),
                // workoutController.error==null
                //     ? workoutController.loading
                //     ? const Center(child:SizedBox(width:50, height:50, child:CircularProgressIndicator()))
                //     : Padding(padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),child:Text(workoutstate.workout?.params?['Description']??'', textAlign: TextAlign.center,))
                //     : const Text('Something went wrong')
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: MainButton(
                      //isEnabled: !workoutController.loading && workoutController.workout!=null,
                      isMain: false,
                      title: 'Discard & Restart',
                      onPressed: () async {
                        await videoBloc.restartRecordingEvent();

                  })
              ,),
            Padding(padding: const EdgeInsets.all(20),
                child: GetBuilder<VideoController>(
                    builder: (videoController) {
                      final isRecording = videoController.recorderState == RecorderState.isRecording || videoController.recorderState == RecorderState.isRestarted;
                      return MainButton(
                        // isEnabled: !videoController.loading && videoController.workout!=null,
                        title: isRecording
                            ? 'Stop Recording'
                            : 'Start Recording',
                          onPressed: () async {
                            await videoBloc.stopRecordingEvent();
                            await Get.toNamed(RoutePaths.videoWorkoutSubmit);
                          }
                      );
                    }))
          ],
        ));}
    );
  }
}
