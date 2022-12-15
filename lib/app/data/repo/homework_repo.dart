import 'package:get/get.dart';
import '../../hive_database/database_repository.dart';
import '../API/api_client.dart';
import '../API/api_url.dart';

class HomeworkRepo extends GetxService{
  final ApiClient apiClient;
  HomeworkRepo({required this.apiClient});

  Future<Response> getAllHomework() async{
    final userId = DataBaseRepository.getUser().id;
    return await apiClient.getData('${ApiUrl.getHomeworksOfUserPath}?userId=$userId');
  }

}