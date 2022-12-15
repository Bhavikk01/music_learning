
// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:math' as min;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/route_paths.dart';
import '../../models/enums/recorder_state.dart';
import '../../widgets/audio_preview.dart';
import '../../widgets/main_button.dart';
import '../../widgets/workout_appbar.dart';
import 'controllers/audio_controller.dart';

class TongueTwisterSubmit extends StatefulWidget {
  const TongueTwisterSubmit({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TongueTwisterSubmitState();

}

class _TongueTwisterSubmitState extends State<TongueTwisterSubmit> {

  late final List<double> decibels;
  late var audioBloc;
  @override
  void initState() {
    audioBloc = Get.find<AudioController>();
    if(audioBloc.recorderState==RecorderState.isStopped){
      log('decibels${audioBloc.decibels}');
      decibels = audioBloc.decibels!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WorkoutAppBar(
          title: 'Doctor Who?',
          subTitle: 'Tongue Twister',
          context: context,),
        body: Column(
          children: [
            Expanded(
                child: GetBuilder<AudioController>(
                    builder:(audioController){
                  return audioController.recorderState==RecorderState.isStopped
                      ? SizedBox(width: 100.w, child: GestureDetector(
                      onTap: (){
                        audioBloc.playRecordingEvent();
                      },
                      child: Image.asset('assets/images/reviewplay.png',)))
                      : Center(child:AudioBarSeries(heights: audioController.decibels!.getRange(0, min.min(audioController.decibels!.length, 16)).toList()));})),
                  Padding(padding: EdgeInsets.only(top: 200.h, left: 20.w, right: 20.w),
                  child:  MainButton(
                  isMain: false,
                  title: 'Discard and Restart', onPressed: () {
                  Navigator.pop(context);
                  audioBloc.restartRecordingEvent();
                  },)
              ,),
            Padding(padding: EdgeInsets.all(20.w),
              child: MainButton(title:'Submit', onPressed: () {
                Navigator.of(context).popUntil((route) => route.settings.name==RoutePaths.workout);
              },),)
          ],
        )
    );
  }
}