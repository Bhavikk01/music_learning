
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../data/controllers/workout_controller.dart';
import '../../models/enums/recorder_state.dart';
import '../../widgets/main_button.dart';
import '../../widgets/workout_appbar.dart';
import 'controllers/audio_controller.dart';

class TongueTwisterMain extends StatefulWidget {
  const TongueTwisterMain({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
  return _TongueTwisterMainState();
  }
}

class _TongueTwisterMainState extends State<TongueTwisterMain> {

  @override
  void initState() {
    Get.find<AudioController>()
        .initRecordingEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recorderWidget = GetBuilder<AudioController>(
        builder: (audioController) {
          final isRecording = audioController.recorderState == RecorderState.isRecording || audioController.recorderState == RecorderState.isRestarted;
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
            Expanded(
                child:
                       workoutController.loading
                        ? Center(child:SizedBox(width:50.w, height: 50.h, child: const CircularProgressIndicator()))
                        : Padding(padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),child:Text(workoutController.workout.params?['ExerciseDescription']??'This is the description', textAlign: TextAlign.center,)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              child: GetBuilder<AudioController>(
                  builder: (audioController) {
                    final isRecording = audioController.recorderState == RecorderState.isRecording
                        || audioController.recorderState == RecorderState.isRestarted;
                    return !isRecording ? MainButton(
                      isMain: false,
                      title: 'Test Audio',
                      onPressed: () {
                        Get.toNamed(RoutePaths.audioTestScreen);
                      },) : MainButton(
                      isEnabled: !workoutController.loading,
                      isMain: false,
                      title: 'Discard & Restart',
                      onPressed: () {
                        audioController.restartRecordingEvent();
                      },);
                  })
              ,),
            Padding(padding: EdgeInsets.all(20.w),
                child: GetBuilder<AudioController>(
                    builder: (audioController) {
                      final isRecording = audioController.recorderState == RecorderState.isRecording
                          || audioController.recorderState == RecorderState.isRestarted;
                      return MainButton(
                        isEnabled: !workoutController.loading&& workoutController.workout!=null,
                        title: isRecording
                          ? 'Stop Recording'
                          : 'Start Recording', onPressed: () async {
                        if (!isRecording) {
                          await audioController.startRecordingEvent();
                        } else {
                          audioController.stopRecordingEvent();
                          await Get.toNamed(RoutePaths.tongueTwisterSubmit);
                        }
                      }
                        ,);
                    }))
          ],
        )
    );
    });
  }
}