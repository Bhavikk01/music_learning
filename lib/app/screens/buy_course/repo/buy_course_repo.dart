
import 'dart:convert';

import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../data/API/api_client.dart';
import '../../../data/API/api_url.dart';
import '../../../data/controllers/course_controller.dart';
import '../../../hive_database/database_repository.dart';
import '../../../models/course.dart';
import '../../../models/enums/course_status.dart';
import '../../../models/enums/pricing_plan.dart';
import '../../../models/enums/subject.dart';
import '../../../models/payment.dart';

class BuyCourseRepo extends GetxService{
  ApiClient apiClient;

  BuyCourseRepo({required this.apiClient});

  razorpayCheckout(Payment payment) async {

    var response = await apiClient.postData(ApiUrl.razorpayCheckoutPath,payment.toMap());
    if(response.statusCode != 200){
      throw Exception(
          '${response.statusCode} occured while razorapy payment checkout');
    }

    var body = response.body;
    var paymentRes = Payment.fromMap(body);

    return paymentRes;
    }

  rechargeCourse(String tutorId, int price, PricingPlan pricing) async {
    var courseId = (await Get.find<CourseController>().getCourseBetweenUserAndTutor(tutorId)).first.id!;
    var response = await apiClient.getData('${ApiUrl.rechargeCoursePath}?courseId=$courseId&price=$price&pricingPlan=${pricingPlanToString(pricing)}');

    if(response.statusCode != 200){
      throw Exception('${response.statusCode} occured while recharging course');
    }
    var body = jsonDecode(response.body);
    var courseRes = Course.fromMap(body);
    return courseRes;
  }

  createCourse(String tutorId, Subject subject, PricingPlan pricingPlan, int price) async {

    var course = Course(
      courseStatus: CourseStatus.paymentPending,
      createUserId: Constants.appName,
      userId: DataBaseRepository.getUser().id,
      currentTutorId: tutorId,
      pricingPlan: pricingPlan,
      subject: subject,
      totalCourseCostYet: price,
    );

    var response = await apiClient.postData(ApiUrl.coursePath, course.toMap());

    if (response.statusCode != 200) {
      throw Exception('${response.statusCode} occured while creating course');
    }
    var body = jsonDecode(response.body);
    var courseRes = Course.fromMap(body);
    return courseRes;
  }

  checkRazorpayPaymentSuccess(
      String paymentId,
      String razorpayPaymentId,
      String signature,) async {
    var response = await apiClient.getData('${ApiUrl.razorpayCheckPaymentSuccessPath}?paymentId=$paymentId&razoppayPaymentId=$razorpayPaymentId&signature=$signature');

    if (response.statusCode != 200) {
      throw Exception(
          '${response.statusCode} occured while checking razorpay success.');
    }
    var body = jsonDecode(response.body);
    var payment = Payment.fromMap(body);
    return payment;
  }

}