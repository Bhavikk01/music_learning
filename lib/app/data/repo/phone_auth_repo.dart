import 'dart:developer';

import 'package:get/get.dart';

import '../../hive_database/database_repository.dart';
import '../../models/enums/phone_auth_user_state.dart';
import '../../models/enums/user_status.dart';
import '../../models/user.dart';
import '../API/api_client.dart';
import '../API/api_url.dart';

class PhoneAuthRepo extends GetxService{

  final ApiClient apiClient;
  PhoneAuthRepo({required this.apiClient});

  Future<PhoneAuthUserState> getUser(String phoneNumber) async{
    phoneNumber =
    phoneNumber.startsWith('+91') ? phoneNumber.substring(3) : phoneNumber;

    var res =  await apiClient.getData('pickit/user/getbyphone?mobile=$phoneNumber');

    if (res.statusCode == 200) {
      var currUser = User.fromMap(res.body);
      await DataBaseRepository.saveUserData(currUser);
      log('User already present');

    } else {
      var body = User(
        mobile: phoneNumber,
        userStatus: UserStatus.signedUp,
      ).toJson();
      var res2 = await apiClient.postData('pickit/user', body);

      var currUser = User.fromMap(res2.body);
      await DataBaseRepository.saveUserData(currUser);

      return PhoneAuthUserState.newUser;
    }

    return PhoneAuthUserState.existingUser;
  }

  authorizeUser(credential) async {
    return await apiClient.postData(ApiUrl.getUser,credential);
  }

}