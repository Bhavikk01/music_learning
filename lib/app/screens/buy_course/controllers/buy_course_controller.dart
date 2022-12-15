// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../constants/constants.dart';
import '../../../data/controllers/course_controller.dart';
import '../../../hive_database/database_repository.dart';
import '../../../models/enums/payment_method.dart';
import '../../../models/enums/payment_status.dart';
import '../../../models/enums/payment_use_case.dart';
import '../../../models/enums/pricing_plan.dart';
import '../../../models/enums/subject.dart';
import '../../../models/payment.dart';
import '../../../models/tutors.dart';
import '../repo/buy_course_repo.dart';

class BuyCourseController extends GetxController{
  BuyCourseRepo buyCourseRepo;
  BuyCourseController({required this.buyCourseRepo});

  late Tutor tutor;
  late Subject subject;
  late PricingPlan plan;
  late bool loading;
  bool isTutorBooked = false;
  bool courseFailed = false;
  bool courseSuccess = false;

  late var paymentRes;
  late PaymentFailureResponse responseFailure;
  late PaymentSuccessResponse responseSuccess;

  getAttributes(Tutor tutor, Subject subject, PricingPlan plan,bool loading){
    this.tutor = tutor;
    this.subject = subject;
    this.plan = plan;
    this.loading = loading;
    courseFailed = false;
    courseSuccess = false;
  }

  checkTutorBooked() async {
    await Get.find<CourseController>()
        .getCourseBetweenUserAndTutor(tutor.id!);

    var count = 0;
    for(var element in Get.find<CourseController>().courses){
      if(tutor.subjectsTaught!.contains(element.subject) && (element.currentTutorId == tutor.id)){
        count++;
      }
    }
    if(count == 0){
      isTutorBooked = false;
    }else{
      isTutorBooked = true;
    }
    log('here is the tutor info: $isTutorBooked');
    return isTutorBooked;
  }

  buyCourse() async {
    try {
      loading = true;
      update();
      var payment = Payment(
        amountInPaise:
        (Constants.pricingTiles[plan]!['price'] as int) * 100,
        createUserId: Constants.appName,
        metadata: {
          subject.name: tutor.name!,
        },
        paymentMethod: PaymentMethod.razorpay,
        paymentTime: DateTime.now().millisecondsSinceEpoch,
        paymentUseCase: await checkTutorBooked()
            ? PaymentUseCase.renewCourse
            : PaymentUseCase.buyCourse,
        pricingPlanId: plan.name,
        status: PaymentStatus.initiated,
        userId: DataBaseRepository.getUser().id,
      );

      await buyCourseRepo.razorpayCheckout(payment).then((paymentRes) async {
      await courseCheckoutRazorpay(paymentRes);
      });
    } catch (e) {
      courseFailed = true;
      courseSuccess = false;
      loading = false;
      isTutorBooked = await checkTutorBooked();
      update();
      log(e.toString());
    }
  }

  courseCheckoutRazorpay(paymentRes) async {
    try {
      var _razorpay = Razorpay()
        ..on(
          Razorpay.EVENT_PAYMENT_SUCCESS,
              (PaymentSuccessResponse response) {
            log('SUCCESS: ${response.paymentId!}');
            this.paymentRes = paymentRes;
            responseSuccess = response;
            coursePaymentSuccess();
          },
        )
        ..on(
          Razorpay.EVENT_PAYMENT_ERROR,
              (PaymentFailureResponse response) {
            log('failed: ${response.code}');
            this.paymentRes = paymentRes;
            responseFailure = response;
            coursePaymentFailure();
          },
        );
      // ..on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

      var options = {
        'key': paymentRes.razorpayKey,
        'amount': (paymentRes.amountInPaise!) +
            (paymentRes.amountInPaise! / 9).round(),
        'order_id': paymentRes.razorpayOrderId,
        'prefill': {
          'contact': DataBaseRepository.getUser().mobile,
          'email': DataBaseRepository.getUser().emailId ?? 'test@razorpay.com',
        },
      };
      _razorpay.open(options);
      isTutorBooked = await checkTutorBooked();
      loading = true;
      log('Here i am to success the course of us');
    } catch (e) {
      courseFailed = true;
      courseSuccess = false;
      loading = false;
      log(e.toString());
    }
  }

  coursePaymentSuccess()async {
    try {
      // var course =
      isTutorBooked = await checkTutorBooked();
      isTutorBooked
          ? await buyCourseRepo.rechargeCourse(
        tutor.id!,
        (((paymentRes.amountInPaise!) +
            (paymentRes.amountInPaise! / 9).round()) /
            100)
            .round(),
        plan,
      )
        : await buyCourseRepo.createCourse(
    tutor.id!,
    subject,
    plan,
    (((paymentRes.amountInPaise!) +
    (paymentRes.amountInPaise! / 9).round()) /
    100)
        .round(),
    );
      await buyCourseRepo.checkRazorpayPaymentSuccess(
        paymentRes.id!,
        responseSuccess.paymentId!,
        responseSuccess.signature!);

    loading = false;
    courseFailed = false;
    isTutorBooked = await checkTutorBooked();
    courseSuccess = true;
    update();
    } catch (e) {
      courseFailed = true;
      courseSuccess = false;
      loading = false;
      update();
      log(e.toString());
    }
  }

  coursePaymentFailure() async {
    log('I am here to fail the course buy2');
    courseFailed = true;
    courseSuccess = false;
    isTutorBooked = await checkTutorBooked();
    loading = false;
    update();
  }

  buyCourseChangePricingPlanEvent(PricingPlan pricingPlan) {
    plan = pricingPlan;
    update();
  }

}