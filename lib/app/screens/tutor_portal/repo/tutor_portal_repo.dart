
import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/API/api_client.dart';
import '../../../data/API/api_url.dart';
import '../../../hive_database/database_repository.dart';
import '../../../models/tutor_metrics.dart';
import '../../../models/workout.dart';

class TutorPortalRepo extends GetxService{
  final ApiClient apiClient;
  TutorPortalRepo({required this.apiClient});

   getQuickTutorMetrics() async {
    var id = DataBaseRepository.getUser().id;
    log(id.toString());
    var response =
          await apiClient.getData('${ApiUrl.getQuickTutorMetrics}?tutorId=$id');

    if (response.statusCode != 200) {
      throw Exception(
          '${response.statusCode} occurred while getting quick tutor metrics'
      );
    }
    var body =response.body;
    log('Here is the tutorMatrices: $body');
    var tutorMetrics = TutorMetrics.fromMap(body);
    return tutorMetrics;
  }

  Future<List<Workout>> getWorkoutBankOfTutor() async {
    var id = DataBaseRepository.getUser().id;
    var response = await apiClient.getData('${ApiUrl.getWorkoutBankOfTutor}?tutorId=$id');
    if(response.statusCode != 200) {
      throw Exception(
          '${response.statusCode} occurred while getting workout bank of tutor'
      );
    }
    var workout = response.body;
    var workoutList = <Workout>[];
    for (var element in workout) {
      workoutList.add(Workout.fromMap(element));
    }
    return workoutList;
  }

  Future<List<dynamic>> getAllCourseOfTutor() async{
    var id = DataBaseRepository.getUser().id;
    var res = await apiClient.getData('${ApiUrl.getAllBatchesOfUser}?tutorId=$id');
    if(res.statusCode != 200) {
      throw Exception(
          '${res.statusCode} occurred while getting workout bank of tutor'
      );
    }
    var batches = res.body;
    return batches;
  }

  Future<List<dynamic>> getAllStudentsOfTutor() async{
    var id = DataBaseRepository.getUser().id;
    var res = await apiClient.getData('${ApiUrl.getAllStudentsByTutor}?tutorId=$id');
    if(res.statusCode != 200) {
      throw Exception(
          '${res.statusCode} occurred while getting workout bank of tutor'
      );
    }
    var students = res.body;
    return students;
  }
}