import 'dart:ui';

import '../config/colors.dart';
import '../models/enums/learning_card_type.dart';
import '../models/enums/pricing_plan.dart';
import '../models/enums/subject.dart';

class Constants {
  Constants._();

  static final pricingTiles = {
    PricingPlan.alaCarte4: {
      'title': '4 classes',
      'price': 499,
    },
    PricingPlan.subscription4: {
      'title': '12 classes',
      'price': 999,
    },
    PricingPlan.alaCarte8: {
      'title': '24 classes',
      'price': 1800,
    },
  };
  static final subjectsMap = {
    Subject.guitar: 'assets/images/guitar.png',
    Subject.piano: 'assets/images/piano.png',
    Subject.vocal: 'assets/images/vocals.png',
    // Subject.tabla: 'assets/images/tabla.png',
    Subject.flute: 'assets/images/flute.png',
    Subject.violin: 'assets/images/violin.png',
    // Subject.bass: 'assets/images/bass.png',
  };

  static const learningCardTitles = {
    LearningCardType.rating: 'Enjoying Pickit?',
    LearningCardType.session: 'Sessions',
    LearningCardType.workout: 'Workouts',
    LearningCardType.course: 'Courses',
  };

  static const learningSessionIcons = {
    Subject.guitar: 'assets/images/guitar_icon.svg',
    Subject.piano: 'assets/images/piano_icon.svg',
    Subject.flute: 'assets/images/flute_icon.svg',
    Subject.bass: 'assets/images/bass_icon.svg',
    Subject.tabla: 'assets/images/tabla_icon.svg',
    Subject.vocal: 'assets/images/vocal_icon.svg',
  };

  static const learningCardBody = {
    LearningCardType.rating: 'Your reviews help us improve!',
    LearningCardType.session: 'Seems like you don\'t have any sessions left!',
    LearningCardType.workout: 'You have completed all your workouts, bravo!',
    LearningCardType.course: '',
  };

  static final learningCardColors = {
    LearningCardType.rating: ThemeColors.lightPink,
    LearningCardType.session: ThemeColors.greenishBlue,
    LearningCardType.workout: ThemeColors.lightPurple,
    LearningCardType.course: ThemeColors.brightGreen,
  };

  static const Color themePrimary = Color(0xFF0A5470);

  static const String guitarImagePath = 'assets/guitar.png';

  static const hiveUserDatabase = 'hiveUserDatabase';

  static const String appLogoPath = 'assets/images/app_logo.png';
  static const String tutorImagePath = 'assets/images/tutor.png';
  static const String tutorSmallImagePath = 'assets/images/tutor_vocal.png';
  static const String googleLogoPath = 'assets/images/google_logo.svg';
  static const String chevronUp = 'assets/images/ChevronUp.png';
  static const String launcherLogo = 'assets/images/launcher_logo.png';
  static const String successImagePath = 'assets/images/success.svg';
  static const String failureImagePath = 'assets/images/failure.svg';
  static const String rec = 'assets/images/rec.png';
  static const String metronomeImagePath = 'assets/images/Metronome.png';
  static const String tanpuraImagePath = 'assets/images/Tanpura.png';
  static const String tunerImagePath = 'assets/images/Tuner.png';
  static const String plus = 'assets/images/plus.svg';
  static const String minus = 'assets/images/minus.svg';
  static const String playIcon = 'assets/images/play.svg';
  static const String pause = 'assets/images/pause.svg';

  static const String tutor = 'Tutor';
  static const String tutors = 'tutors';
  static const String tanpuraUrl = 'https://util.pickit.live/drone';
  static const String metronomeUrl = 'https://util.pickit.live/';
  static const String tunerUrl = 'https://util.pickit.live/tuner';
  static const String bgVideoPath = 'assets/videos/bg_video.mp4';

  static const emptySpace = ' ';

  static const String appName = 'Pickit';

  static const String signUp = 'Sign Up';
  static const String signIn = 'Sign In';
  static const String signOut = 'Sign Out';

  static const String save = 'Save';
  static const String or = 'or';
  static const String exploreApp = 'Explore the app!';
  static const String explore = 'Explore';
  static const String myLearning = 'My Learning';
  static const String utilities = 'Utilities';
  static const String muchEmpty = 'Much Empty!';
  static const String emptyLearningNote =
      'All your courses and learning material will appear here once you start your journey';

  static const String introPageTitle = 'Start your musical journey!';

  static const String name = 'Name';
  static const String phone = 'Phone';
  static const String phoneNumber = 'Phone Number';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String forgot = 'Forgot';
  static const String orWithEmail = 'Or with Email';
  static const String hintForSignUp = 'Don\'t have an account?';
  static const String continueText = 'Continue';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithEmail = 'Continue with Email';
  static const String invalidEmail = 'Invalid Email';
  static const String invalidPhoneNumber = 'Invalid Phone Number';
  static const String invalidTutorPhoneNumber = 'Invalid Tutor Phone Number';
  static const String invalidPassword =
      'Invalid Password, Must be atleast 6 characters long';
  static const String verify = 'Verify';
  static const String verificationCode = 'Verification Code';
  static const String resendOtp = 'Resend after 30 seconds';
  static const String verificationCodeInput = 'Enter Your Verification Code';
  static const String forgotPassword = 'Forgot Password';
  static const String sendOtp = 'We will send OTP to your phone';
  static const String send = 'Send';
  static const String game = 'Game';
  static const String viewAll = 'View All';
  static const String learn = 'Learn';
  static const String play = 'Play';
  static const String success = 'Success!';
  static const String failed = 'Failed!';
  static const String purchaseSuccessNote =
      'You\'ve just taken the first step in your musical journey.\nBook your first session and start learning!';
  static const String purchaseFailedNote = 'Something went wrong!';
  static const String retry = 'Retry';

  static const String course = 'Course';
  static const String courses = 'Courses';
  static const String teacher = 'Teacher';
  static const String buyCourse = 'Buy Course';
  static const String buy = 'Book';

  static const String bookDemo = 'Book Demo';
  static const String rebuyCourse = 'Rebuy Course';
  static const String book = 'Book';
  static const String vocals = 'Vocals';
  static const String bookDemoConfirmation =
      'Thank you for booking a demo with us!\n\nYou will receive a confirmation message soon!';

  static const String buyCourseConfirmation =
      'Thank you for buying a course with us!\n\nYou will receive a confirmation message soon!';
  static const String selectTutor = 'Select Tutor';
  static const String selectCourse = 'Select Course';
  static const String selectPlan = 'Select Plan';
  static const String total = 'Total: ';
  static const String purchaseSuccesful = 'Purchase Successful!';

  static const String discover = 'Discover';

  static const String account = 'Account';
  static const String payment = 'Payment';
  static const String policy = 'Policy';
  static const String notification = 'Notification';
  static const String privacyPolicy = 'Privacy & Policy';
  static const String ourTutors = 'Our Tutors';
  static const String tutorProfile = 'Tutor Profile';
  static const String studentShowcase = 'Student Showcase';
  static const String inactiveLink = 'Meeting link is not active';
  static const String invalidLink = 'Meeting link is invalid ';

  static const String preference = 'Preference';
  static const String music = 'Music';
  static const String dance = 'Dance';
  static const String leaveFeedback = 'Leave Feedback';
  static const String rateUs = 'Rate Us';
  static const String viewPending = 'View Pending Workouts';
  static const String viewInProgress = 'View In Progress Workouts';
  static const String resumePlaying = 'Resume Playing';
  static const String startPlaying = 'Start Playing';
  static const String viewSubmissions = 'View Submissions';
  static const String bookSession = 'Book Session';
  static const String availableSlots = 'Available Slots';
  static const String mySessions = 'My Sessions';
  static const String myCourses = 'My Courses';
  static const String myWorkouts = 'My Workouts';
  static const String workout = 'Workout';
  static const String completedWorkouts = 'Completed Workouts';
  static const String inProgressWorkouts = 'In Progress Workouts';
  static const String pendingWorkouts = 'Pending Workouts';
  static const String workoutsInProgress = 'Workouts In Progress';
  static const String filters = 'Filters';
  static const String searchSessions = 'Search Sesssions';
  static const String connect = 'Connect';
  static const String cancel = 'Cancel';
  static const String replay = 'Replay';
  static const String exit = 'Exit';
  static const String reschedule = 'Reschedule';
  static const String viewAllCourses = 'View All Courses';
  static const String viewRecording = 'View Recording';
  static const String upcoming = 'Upcoming';
  static const String past = 'Past';
  static const String pending = 'Pending';
  static const String submitted = 'Submitted';
  static const String active = 'Active';
  static const String inactive = 'Inactive';
  static const String about = 'About';
  static const String congratulations = 'Congratulations!';
  static const String tryAgain = 'Try again!';
  static const String reviews = 'Reviews';
  static const String skipForNow = 'Skip for now';
}
