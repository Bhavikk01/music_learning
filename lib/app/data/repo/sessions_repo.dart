
import 'package:get/get.dart';
import '../../hive_database/database_repository.dart';
import '../../models/session.dart';
import '../API/api_client.dart';
import '../API/api_url.dart';

class SessionRepo extends GetxService{
  final ApiClient apiClient;
  SessionRepo({required this.apiClient});

  Future<Response> getAllSessions() async{
    final userId = DataBaseRepository.getUser().id;
    var response =  await apiClient.getData('${ApiUrl.getSessionsOfUserPath}?userId=$userId');
    return response;
  }

  Future<void> bookSession(Session session) async{

    //TODO: Have to complete this thing
    var response = await apiClient.postData(ApiUrl.bookSessionPath,session.toMap());

  }

}