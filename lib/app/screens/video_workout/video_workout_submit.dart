
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../constants/route_paths.dart';
import '../../widgets/main_button.dart';
import 'controllers/video_controller.dart';

class VideoRecordingSubmit extends StatefulWidget {
  const VideoRecordingSubmit({Key? key}) : super(key: key);

  @override
  State<VideoRecordingSubmit> createState() => _VideoRecordingSubmitState();
}

class _VideoRecordingSubmitState extends State<VideoRecordingSubmit> {

  late VideoPlayerController videoPlayerController;
  late final videoBloc;

  @override
  void initState() {
    videoBloc = Get.find<VideoController>();
    videoPlayerController = VideoPlayerController.file(File(videoBloc.file!.path));
    super.initState();
  }

  @override
  void activate() {
    videoPlayerController = VideoPlayerController.file(File(videoBloc.file!.path));
    super.activate();
  }
  
  @override
  Widget build(BuildContext context) {
    videoPlayerController.initialize().then((value) =>
        videoPlayerController.play()
    );
    final top = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Padding(padding:EdgeInsets.only(top:top),child:VideoPlayer(videoPlayerController))
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
                  await Get.toNamed(RoutePaths.videoWorkoutCamera);
                })
            ,),
          Padding(padding: const EdgeInsets.all(20),
              child: MainButton(title: 'Submit', onPressed: () {

              }))
        ],
      ),
    );
  }
  @override
  void deactivate() {
    videoPlayerController.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }
}
