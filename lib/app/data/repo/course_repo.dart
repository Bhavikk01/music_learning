import 'package:get/get.dart';
import '../../hive_database/database_repository.dart';
import '../API/api_client.dart';
import '../API/api_url.dart';

class CourseRepo extends GetxService{
  final ApiClient apiClient;
  CourseRepo({required this.apiClient});

  Future<Response> getAllCourse() async{
    final userId = DataBaseRepository.getUser().id;
    return await apiClient.getData('${ApiUrl.getCoursesOfUserPath}?userId=$userId');
  }

  Future<Response> getCourseBetweenUserAndTutor(String tutorId) async {
    final userId = DataBaseRepository.getUser().id;
    return await apiClient.getData('${ApiUrl.getCoursesOfUserPath}?tutorId=$tutorId&userId=$userId');
  }

}