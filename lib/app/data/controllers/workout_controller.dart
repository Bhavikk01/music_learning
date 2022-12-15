
import 'dart:developer';

import 'package:get/get.dart';

import '../../models/workout.dart';
import '../API/api_client.dart';

class WorkoutController extends GetxController implements GetxService{

  Workout workout = const Workout();
  late Object? error;
  late bool loading;
  late Map<String, String> param;

  getBoolAttribute(bool loading){
    this.loading = loading;
  }

  fetchWorkoutEvent(String id) async {
    try{
      getBoolAttribute(true);
      update();
      param = {'id': id};
      log('id is : $id');
      workout = await ApiClient().getWorkout(id: param['id']);
      log('this is the demo workout: $workout');
      getBoolAttribute(false);
      update();
    }catch(e){
      error = e;
      update();
    }
  }
}