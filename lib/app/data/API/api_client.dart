import 'dart:developer';

import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../hive_database/database_repository.dart';
import '../../models/enums/session_status.dart';
import '../../models/enums/session_type.dart';
import '../../models/enums/subject.dart';
import '../../models/session.dart';
import '../../models/tutors.dart';
import '../../models/user.dart';
import '../../models/workout.dart';
import 'api_url.dart';

class ApiClient extends GetConnect implements GetxService{


  late String token;
  String appBaseUrl = 'http://10.10.41.113:5000/';

  ApiClient({this.appBaseUrl = 'http://192.168.102.27:5000/'});

  Future<void> updateUser(User user) async {
    await put('${ApiUrl.baseUrl}user',user.toJson(),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json'
      },
    );
  }

  Future<Response> getData(String uri) async{
    try{
      var response = await get(appBaseUrl+uri);
      return response;
    }catch(e){
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Response> postData(String uri,dynamic body)async{
    try{
      var response = await post(appBaseUrl+uri, body);
      return response;
    }catch(e){
      log(e.toString());
      return Response(statusCode: 1,statusText: e.toString());
    }
  }

  Future<Session> bookDemoSession(
      Tutor tutor,
      DateTime startTime,
      Subject subject,
      ) async {
    final userId = DataBaseRepository.getUser().id;
    var url = '$appBaseUrl${ApiUrl.bookDemoSessionPath}';
    final session = Session(
      createUserId: Constants.appName,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: startTime.add(const Duration(hours: 1)).millisecondsSinceEpoch,
      sessionStatus: SessionStatus.scheduled,
      tutorId: tutor.id,
      userId: userId,
      sessionType: SessionType.musicDemo,
      subject: subject,
    );

    var res = await post(
      url,session.toJson(),
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json'
      },
    );

    if (res.statusCode != 200) {
      throw Exception('${res.statusCode} occured while creating course');
    }
    var sessionRes = Session.fromMap(res.body);
    return sessionRes;
  }

  Future<Tutor> getTutor(String tutorId) async {
    final url = '$appBaseUrl${ApiUrl.tutorPath}?id=$tutorId';

    final res = await get(url);

    final tutor = Tutor.fromMap(res.body);

    return tutor;
  }

  Future<Response> assignWorkoutToCourse(data) async {
    var response = await post(
        appBaseUrl+ApiUrl.assignWorkoutToCourse,
        data,
        headers: {
          'Accept': 'application/json',
          'content-type':'application/json'
        }
    );
    if(response.statusCode != 200){
      throw Exception(
          '${response.statusCode} occurred while posting homework'
      );
    }
    return response;
  }

  Future<Workout> getWorkout({String? id}) async{
    var res = await get('$appBaseUrl${ApiUrl.getWorkoutPath}?id=$id');
    if (res.statusCode != 200) {
      throw Exception(
          '${res.statusCode} occured while getting workout.');
    }
    var workout = Workout.fromMap(res.body);
    return workout;
  }

}