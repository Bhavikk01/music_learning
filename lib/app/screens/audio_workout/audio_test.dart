import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../data/controllers/workout_controller.dart';
import '../../models/enums/recorder_state.dart';
import '../../widgets/main_button.dart';
import '../../widgets/workout_appbar.dart';
import 'controllers/audio_controller.dart';

class AudioTestScreen extends StatefulWidget {
  const AudioTestScreen({Key? key}) : super(key: key);

  @override
  State<AudioTestScreen> createState() => _AudioTestScreenState();
}

class _AudioTestScreenState extends State<AudioTestScreen> with SingleTickerProviderStateMixin, WidgetsBindingObserver{

  late AnimationController _animationController;

  @override
  void initState() {
    Get.find<AudioController>()
        .initRecordingEvent();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
    _animationController.addListener(() {setState(() {

    }); });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<AudioController>();
    final recorderWidget = GetBuilder<AudioController>(
        builder: (audioController) {
          final isRecording = audioController.recorderState == RecorderState.isRecording
              || audioController.recorderState == RecorderState.isRestarted;
          return isRecording
              ? Image.asset(Constants.rec, height: 50,)
              : const SizedBox();
        });
    return GetBuilder<WorkoutController>(
        builder: (workoutController){
      return Scaffold(
        appBar: WorkoutAppBar(
          title: workoutController.workout.workoutName??'',
          subTitle: workoutController.workout.params?['Subtitle']??'',
          context: context,),
        body: Column(
          children: [
            recorderWidget,
            const Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child:Text(
                      'Test your mic input\n\nKindly connect a microphone to your device & make sure that you’re seated in a quiet environment.\n\nTap the button below & count from 1 till 5 to test your mic input level',
                      textAlign: TextAlign.center,))
            ),
            SizedBox(height: 80,
              child: GetBuilder<AudioController>(
                  builder: (state) {
                    // return AudioBarSeries(heights: state.decibels??[]);
                    return state.playing
                        ? SpinKitWave(
                      color: Colors.greenAccent,
                      size: 50.h,
                      controller: _animationController,
                    )
                        : Container();
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
              child: GetBuilder<AudioController>(
                  builder: (audioController) {
                    final isRecording = audioController.recorderState == RecorderState.isRecording
                        || audioController.recorderState == RecorderState.isRestarted;
                    return !isRecording
                        ? MainButton(
                      isMain: false,
                      title: 'Back',
                      onPressed: () async {
                        await audioController.stopRecordingEvent();
                        Navigator.of(context).pop();
                      },)
                        : MainButton(
                      isEnabled: !workoutController.loading,
                      isMain: false,
                      title: 'Discard & Restart',
                      onPressed: () async {
                        await audioController.restartRecordingEvent();
                      },);
                  })
              ,),
            Padding(padding: EdgeInsets.all(20.w),
                child: GetBuilder<AudioController>(
                    builder: (audioController) {
                      final isRecording = audioController.recorderState == RecorderState.isRecording || audioController.recorderState == RecorderState.isRestarted;
                      return MainButton(
                        isEnabled: !workoutController.loading,
                        title: isRecording
                            ? 'Stop Test Recording'
                            : 'Start Test Recording', onPressed: () async {
                        if (!isRecording) {
                          await audioController.stopRecordingEvent();
                          Future.delayed(const Duration(seconds: 2), () async {
                              audioController.startRecordingEvent();
                            });
                        } else {
                          await audioController.stopRecordingEvent();
                          Future.delayed(const Duration(seconds: 2), () async {
                              await audioController.playRecordingEvent();
                            },
                          );
                        }},
                      );
                    },
                ),
            )
          ],
        )
    );});
  }
}
