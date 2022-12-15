import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../hive_database/database_repository.dart';
import '../../models/enums/phone_auth_model.dart';
import '../../models/enums/phone_auth_user_state.dart';
import '../../models/enums/user_status.dart';
import '../../models/phone_auth_model.dart';
import '../../models/user.dart' as user;
import '../repo/phone_auth_repo.dart';
import 'tutor_controller.dart';

class PhoneAuthController extends GetxController{

  final PhoneAuthRepo phoneAuthRepo;
  PhoneAuthController({required this.phoneAuthRepo});

  late String phoneNumber;
  final _firebaseAuth = FirebaseAuth.instance;
  String verificationId = '';
  String otp = '';
  late bool isTutor;
  late bool tutorAvailable;

  PhoneAuthModel phoneAuthModel = const PhoneAuthModel(
    phoneAuthModelState: PhoneAuthModelState.error,
    userState: PhoneAuthUserState.newUser,
    uid: '',
  );

  void takePhoneNumber(String phoneNumber, bool isTutor){
    this.phoneNumber = phoneNumber;
    this.isTutor = isTutor;
  }

  void takeOtp(String otp){
    this.otp = otp;
  }

  Future<void> verifyPhoneNumber() async {

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',

      verificationCompleted: (PhoneAuthCredential credential) async {
        await _firebaseAuth.signInWithCredential(credential).then((value) async {
          PhoneAuthUserState userState;
          if(tutorAvailable){
            userState = PhoneAuthUserState.existingUser;
            // var body = user.User(
            //   mobile: phoneNumber,
            //   userStatus: UserStatus.signedUp,
            // );
            // await DataBaseRepository.saveUserData(body);
          }else {
            userState = await phoneAuthRepo.getUser(phoneNumber);
          }
          if (value.user != null) {
            return PhoneAuthModel(
              phoneAuthModelState: PhoneAuthModelState.verified,
              userState: userState,
              uid: value.user!.uid,
            );
          }else{
            return const PhoneAuthModel(
              phoneAuthModelState: PhoneAuthModelState.error,
              userState: PhoneAuthUserState.newUser,
            );
          }
        });
      },
      verificationFailed: (FirebaseAuthException exception) =>log(exception.toString()),
      codeSent: (String verificationId, int? token) async {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationid){},
      timeout: const Duration(seconds: 60),
    );
  }

  Future<PhoneAuthModel> verifySMSCode() async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );
    final value = await _firebaseAuth.signInWithCredential(credential);
    if (value.user != null) {
      final PhoneAuthUserState userState;

      if(tutorAvailable){
        userState = PhoneAuthUserState.existingUser;
        Response response = await Get.find<TutorController>()
            .getTutorByPhoneNumber(phoneNumber);
        await DataBaseRepository.saveUserData(user.User.fromMap(response.body));
      }else {
        userState = await phoneAuthRepo.getUser(phoneNumber);
      }
      phoneAuthModel = PhoneAuthModel(
        phoneAuthModelState: PhoneAuthModelState.verified,
        userState: userState,
        uid: value.user!.uid,
      );
      update();
      return phoneAuthModel;
    }else{
      phoneAuthModel =  const PhoneAuthModel(
        phoneAuthModelState: PhoneAuthModelState.error,
        userState: PhoneAuthUserState.newUser,
      );
      return phoneAuthModel;
    }
  }

  authorizeUser(credential) async {
    var body = user.User(
      mobile: credential,
      userStatus: UserStatus.signedUp,
    ).toJson();

    Response response = await phoneAuthRepo.authorizeUser(body);
    log('This is the body: ${response.body}, ${response.statusCode}');
    if(response.statusCode == 200){
      return true;
    }else{
      return false;
    }
  }

  //Tutor things
  verifyTutorPhoneNumber() async {
    Response response = await Get.find<TutorController>().getTutorByPhoneNumber(phoneNumber);
    if(response.statusCode == 200){
      log('Tutor exist');
      tutorAvailable = true;
      await verifyPhoneNumber();
    }else{
      tutorAvailable = false;
    }
  }

}