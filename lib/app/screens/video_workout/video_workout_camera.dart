// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/route_paths.dart';
import '../../models/enums/recorder_state.dart';
import '../../widgets/main_button.dart';
import 'controllers/video_controller.dart';

class VideoCameraWorkout extends StatefulWidget {
  const VideoCameraWorkout({Key? key}) : super(key: key);

  @override
  State<VideoCameraWorkout> createState() => _VideoCameraWorkoutState();
}

class _VideoCameraWorkoutState extends State<VideoCameraWorkout> {

  late final videoBloc;


  @override
  void initState() {
    late final CameraController controller;
    videoBloc = Get.find<VideoController>();
    late final List<CameraDescription> cameras;
    availableCameras().then((value) async {
      cameras = value;
      controller = CameraController(
          cameras.first,
          ResolutionPreset.ultraHigh
      );
      videoBloc.initRecordingEvent(controller).then((_){});
    });

      if(videoBloc.recorderState==RecorderState.isRecording){
        Navigator.of(context).pushReplacementNamed(RoutePaths.videoWorkoutRecording);
      }
      if(videoBloc.permissionStatus != ''){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((videoBloc).e.toString())));
      }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final top = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Padding(padding:EdgeInsets.only(top:top),child:Stack(
        children: [
          GetBuilder<VideoController>(
              builder: (videoController){
            if(videoController.recorderState == RecorderState.notStarted) {
              return CameraPreview(videoController.controller);
            }else{
              return const Center(child: CircularProgressIndicator(),);
            }
          }),
          Positioned(
            width: width,
            child: Padding(padding: const EdgeInsets.all(20),
              child: MainButton(
                  isEnabled: true,//!workoutController.loading && workoutController.workout!=null,
                  title: 'Start Recording',
                  onPressed: () async {
                  await videoBloc.startRecordingEvent().then((_){
                    if(videoBloc.recorderState==RecorderState.isRecording){
                      Navigator.of(context).pushReplacementNamed(RoutePaths.videoWorkoutRecording);
                    }
                    if(videoBloc.permissionStatus != ''){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text((videoBloc).e.toString())));
                    }
                  });
              })
          ), bottom: 0,)
        ],
      ),
    ));

  }
}
