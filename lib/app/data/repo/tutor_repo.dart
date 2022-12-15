import 'package:get/get.dart';
import '../API/api_client.dart';
import '../API/api_url.dart';

class TutorRepo extends GetxService{
  final ApiClient apiClient;

  TutorRepo({required this.apiClient});
  
  Future<Response> getAllTutors() async{
    return await apiClient.getData(ApiUrl.getTutorsPath);
  }
  
  getTutor(String tutorId) async{
    return await apiClient.getData('${ApiUrl.tutorPath}?id=$tutorId');
  }

  getTutorByPhoneNumber(String phoneNumber) async {
    return await apiClient.getData('${ApiUrl.tutorPath}/getbyphone?mobile=$phoneNumber');
  }

}