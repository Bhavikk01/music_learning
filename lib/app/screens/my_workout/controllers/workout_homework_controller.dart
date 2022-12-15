
import 'package:get/get.dart';

import '../../../data/controllers/homework_controller.dart';
import '../../../models/homework.dart';

class WorkOutHomeworkController extends GetxController implements GetxService {
  late bool loading;
  late List<HomeWork>? homeworks;

  fetchHomeWorkData() async {
    loading = true;
    update();
    await Get.find<HomeworkController>().getAllHomework();
    homeworks = Get.find<HomeworkController>().homeworkList;
    loading = false;
    update();
  }
}