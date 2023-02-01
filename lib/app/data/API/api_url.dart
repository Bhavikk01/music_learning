class ApiUrl {
  ApiUrl._();

  static const String baseUrl = 'http://10.10.40.217:5000/';
  static const String userPath = 'pickit/user';
  static const String createUser = 'api/createUser';
  static const String getUser = 'api/getUser';
  static const String getAllUsersPath = 'pickit/user/getAllUsers';
  static const String getByPhonePath = 'pickit/user/getbyphone';
  static const String studentShowcasePath = 'pickit/user/showcase';

  static const String coursePath = 'pickit/course';
  static const String rechargeCoursePath = 'pickit/course/rebuy';
  static const String registerCoursePath = 'pickit/course/register';
  static const String tutorCoursePath = 'pickit/course/tutor';
  static const String userCoursesPath = 'pickit/course/user';
  static const String getCourseBetweenUserAndTutor = 'pickit/course/userXtutor';

  static const String tutorPath = 'pickit/tutor';
  static const String getTutorByPhonePath = 'pickit/tutor/getbyphone';
  static const String getTutorsPath = 'pickit/tutor/list';
  static const String getQuickTutorMetrics = 'pickit/tutor/quickTutorMetrics';
  static const String getAllHomeworkOfTutor = 'pickit/homework/getByTutor';
  static const String getWorkoutBankOfTutor = 'pickit/workout/tutor';
  static const String getAllBatchesOfUser = 'pickit/course/tutor';
  static const String getTutorByPhoneNumber = 'pickit/tutor/getbyphone';

  static const String bookDemoSessionPath = 'pickit/session/demo';
  static const String getDemoBetweenUserTutor = 'pickit/session/getdemoWithTutor';
  static const String bookSessionPath = 'pickit/session';
  static const String getSessionsOfUserPath = 'pickit/session/user';
  static const String getSessionsOfTutorPath = 'pickit/session/scheduledTutorSessions';
  static const String getHomeworksOfUserPath = 'pickit/homework/getByUser';
  static const String getCoursesOfUserPath = 'pickit/course/user';

  static const String razorpayCheckoutPath = 'pickit/payment/razorpayCheckout';
  static const String razorpayCheckPaymentSuccessPath = 'pickit/payment/razorpaySuccess';

  static const String getWorkoutPath = 'pickit/workout';
  static const String getAllStudentsByTutor = 'pickit/course/studentsByTutor';
  static const String assignWorkoutToCourse = 'pickit/homework/assignToCourse';




}
