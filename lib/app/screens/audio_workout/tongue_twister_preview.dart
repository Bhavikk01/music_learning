import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../data/controllers/workout_controller.dart';
import '../../widgets/main_button.dart';
import '../../widgets/workout_appbar.dart';

class TongueTwisterPreview extends StatefulWidget{
  final String id;
  const TongueTwisterPreview({Key? key,required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState(){

    return _TongueTwisterPreviewState();
  }
}

class _TongueTwisterPreviewState extends State<TongueTwisterPreview> with SingleTickerProviderStateMixin, WidgetsBindingObserver{
  late AnimationController _animationController;
  late Timer _timer;
  late AudioPlayer audioPlayer;

  void loadData() async{
    await Get.find<WorkoutController>()
        .fetchWorkoutEvent(widget.id);
  }
  @override
  void initState() {
    audioPlayer = AudioPlayer();
    loadData();
    _animationController = AnimationController(vsync: this);
    _animationController.addListener(() {setState(() {

    });});
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _animationController.animateTo(1.0, curve: Curves.easeInOut, duration: const Duration(seconds: 1))
          .then((value) => _animationController.animateBack(0.8, curve: Curves.easeInOut, duration: const Duration(seconds: 1)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkoutController>(
        builder: (workoutController) {
          try{
            audioPlayer.play(workoutController.workout.params!['Intro_audio']!, isLocal: false);
      }catch(e){
            log(e.toString());
          }
      return !workoutController.loading?Scaffold(
          appBar: WorkoutAppBar(
            title: workoutController.workout.workoutName??'',
            subTitle: workoutController.workout.params?['Subtitle']??'',
            context: context,),
          body: Column(children: [
            Expanded(
              child: Center(
                child: Container(
                  height: _animationController.value * 150,
                  width: _animationController.value * 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          _animationController.value * 150 / 2),
                      color: const Color(0Xffa9c1ff)
                  ),
                  child: Center(
                    child: Image.asset(Constants.launcherLogo, height: 100.h,),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(20.w),
              child: MainButton(title: 'Proceed', onPressed: () {
                audioPlayer..stop()..dispose();
                Get.toNamed(RoutePaths.tongueTwisterMain);
              },),)
          ],)
      ):const Scaffold(
        body: Center(child: CircularProgressIndicator(),),
      );});
  }
  
  @override
  void dispose() {
    audioPlayer.dispose();
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }
}