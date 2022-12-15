import 'dart:developer';

import 'package:get/get.dart';

import '../../models/homework.dart';
import '../repo/homework_repo.dart';

class HomeworkController extends GetxController{
  final HomeworkRepo homeworkRepo;
  HomeworkController({required this.homeworkRepo});


  List<HomeWork> homeworkList = [];

  getAllHomework() async {
    homeworkList = [];
    var response = await homeworkRepo.getAllHomework();
    // var homeworks = HomeWork.fromMap(response.body);
    var homework = response.body;
    log('Here is the response of workouts: ${response.body}');
    for(var element in homework){
      homeworkList.add(HomeWork.fromMap(element));
    }
    homeworkList.sort(((a, b) => a.createdAt!.compareTo(b.createdAt!)));
    update();
  }

}