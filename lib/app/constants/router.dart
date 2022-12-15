
import 'package:flutter/material.dart';
import '../models/enums/subject.dart';
import '../models/homework.dart';
import '../screens/audio_workout/audio_test.dart';
import '../screens/audio_workout/tongue_twister_main.dart';
import '../screens/audio_workout/tongue_twister_preview.dart';
import '../screens/audio_workout/tongue_twister_submit.dart';
import '../screens/auth/auth_screen.dart';
import '../screens/auth/on_boarding_screen.dart';
import '../screens/auth/verification_screen.dart';
import '../screens/book_demo/book_demo_screen.dart';
import '../screens/book_with_slots.dart/book_demo_with_slot.dart';
import '../screens/book_with_slots.dart/book_session_with_slot.dart';
import '../screens/book_with_slots.dart/session_booking_sucess_screen.dart';
import '../screens/buy_course/screens/buy_course_screen.dart';
import '../screens/buy_course/screens/purchase_failed_screen.dart';
import '../screens/buy_course/screens/purchase_success_screen.dart';
import '../screens/course_preference/course_preference_screen.dart';
import '../screens/ear_training_workout.dart/screen/ear_training_intro_screen.dart';
import '../screens/ear_training_workout.dart/screen/ear_training_screen.dart';
import '../screens/home_screens/screens/course_screen.dart';
import '../screens/home_screens/screens/homePage.dart';
import '../screens/home_screens/screens/home_screen.dart';
import '../screens/home_screens/screens/my_learning_screen.dart';
import '../screens/home_screens/screens/web_view_screen.dart';
import '../screens/home_screens/widgets/utilities_screen.dart';
import '../screens/my_courses/my_courses_screen.dart';
import '../screens/my_workout/my_workout.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/session/session_screen.dart';
import '../screens/subject_screen/screens/subject_screen.dart';
import '../screens/tutor_portal/assign_proceeding_screen.dart';
import '../screens/tutor_portal/assign_workout_screen.dart';
import '../screens/tutor_portal/feedback_screen.dart';
import '../screens/tutor_portal/main_screen.dart';
import '../screens/tutor_portal/manage_submission_screen.dart';
import '../screens/tutor_portal/my_batches_screen.dart';
import '../screens/tutor_portal/my_students.dart';
import '../screens/tutor_portal/review_student_screen.dart';
import '../screens/tutor_portal/student_list_screen.dart';
import '../screens/tutor_portal/submission_details_screen.dart';
import '../screens/tutor_portal/workout_bank_screen.dart';
import '../screens/tutor_portal/workout_booking_success_screen.dart';
import '../screens/tutor_profile/tutor_profile_screen.dart';
import '../screens/tutor_screen/tutor_screen.dart';
import '../screens/video_workout/video_workout_camera.dart';
import '../screens/video_workout/video_workout_main.dart';
import '../screens/video_workout/video_workout_preview.dart';
import '../screens/video_workout/video_workout_recording.dart';
import '../screens/video_workout/video_workout_submit.dart';
import '../screens/workout/screen/completed_workout_screen.dart';
import '../screens/workout/screen/in_progress_screen.dart';
import '../screens/workout/screen/workout_screen.dart';
import 'route_paths.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  return MaterialPageRoute(
    settings: settings,
    builder: (BuildContext context) {
      switch (settings.name) {
        case RoutePaths.onBoardingScreen:
          return const OnBoardingScreen();

        case RoutePaths.signInScreen:
          return const SignInScreen();

        // case RoutePaths.signUpScreen:
        //   return const SignUpScreen();

        // case RoutePaths.emailSignUpScreen:
        //   return const EmailSignUpScreen();
        //
        // case RoutePaths.forgotPasswordScreen:
        //   return const ForgotPassword();

        case RoutePaths.verificationScreen:
          return const VerificationScreen();

        case RoutePaths.homeScreen:
          return HomeScreen(
            index: settings.arguments as int? ?? 0,
          );

        case RoutePaths.homePage:
          return const HomePage();

        case RoutePaths.subjectScreen:
          return  SubjectScreen(subjects: settings.arguments as Subject);

        case RoutePaths.tutorProfileScreen:
          return TutorProfileScreen(
            tutor: (settings.arguments as Map<String, dynamic>)['tutor'],
            subject: (settings.arguments as Map<String, dynamic>)['subject'],
            isDemoAvailable: (settings.arguments
                    as Map<String, dynamic>)['isDemoAvailable'] ??
                false,
          );

        case RoutePaths.demoBook:
          return BookDemoScreen(
            tutor: (settings.arguments as Map<String, dynamic>)['tutor'],
            subject: (settings.arguments as Map<String, dynamic>)['subject'],
            slot: (settings.arguments as Map<String, dynamic>)['slot'],
          );

        case RoutePaths.buyCourse:
          return BuyCourseScreen(
            tutor: (settings.arguments as Map<String, dynamic>)['tutor'],
            subject: (settings.arguments as Map<String, dynamic>)['subject'],
          );

        case RoutePaths.tutorScreen:
          return const TutorScreen();

        case RoutePaths.profileScreen:
          return const ProfileScreen();

        case RoutePaths.coursePreferenceScreen:
          return const CoursePreferenceScreen();
        //
        case RoutePaths.myLearningScreen:
          return const MyLearningScreen();

        case RoutePaths.utilitiesScreen:
          return const UtilitiesScreen();
        //
        case RoutePaths.webviewScreen:
          return WebViewScreen(url: settings.arguments as String);

        case RoutePaths.courseScreen:
          return const CourseScreen();

        case RoutePaths.bookDemoWithSlotScreen:
          return BookDemoWithSlotScreen(
            tutor: (settings.arguments as Map<String, dynamic>)['tutor'],
            subject: (settings.arguments as Map<String, dynamic>)['subject'],
          );

        case RoutePaths.sessionScreen:
          return const SessionScreen();

        case RoutePaths.workoutScreen:
          return HomeworkScreen(
            homeworks: settings.arguments as List<HomeWork>,
          );

        case RoutePaths.myCourseScreen:
          return const MyCourseScreen();

        case RoutePaths.purchaseSuccessScreen:
          return const PurchaseSuccessScreen();

        case RoutePaths.purchaseFailedScreen:
          return const PurchaseFailedScreen();

        case RoutePaths.bookSessionScreen:
          return const BookSessionScreen();

        case RoutePaths.bookSessionSuccessScreen:
          return const SessionBookingSuccessScreen();

        case RoutePaths.completedWorkoutScreen:
          return CompletedHomeworkScreen(
            homeworks: settings.arguments as List<HomeWork>,
          );

        case RoutePaths.earTrainingScreen:
          return const EarTrainingScreen();

        case RoutePaths.inProgressWorkoutScreen:
          return InProgressScreen(
            homeworks: settings.arguments as List<HomeWork>,
          );

        case RoutePaths.earTrainingIntroScreen:
          return EarTrainingIntroScreen(
            homeWork: settings.arguments as HomeWork,
          );


        case RoutePaths.workoutBookingSuccessScreen:
          return WorkoutBookingSuccessScreen(
            userData: settings.arguments,
          );

        case RoutePaths.workout:
          return const MyWorkout();

        case RoutePaths.tongueTwisterPreview:
          return TongueTwisterPreview(id: settings.arguments as String);

        case RoutePaths.tongueTwisterMain:
          return const TongueTwisterMain();

        case RoutePaths.audioTestScreen:
          return const AudioTestScreen();

        case RoutePaths.tongueTwisterSubmit:
          return const TongueTwisterSubmit();

        case RoutePaths.videoWorkoutPreview:
          return VideoWorkoutPreview(id: settings.arguments as String);

        case RoutePaths.videoWorkoutMain:
          return const VideoWorkoutMain();

        case RoutePaths.videoWorkoutCamera:
          return const VideoCameraWorkout();

        case RoutePaths.videoWorkoutRecording:
          return  const VideoWorkoutRecording();

        case RoutePaths.videoWorkoutSubmit:
          return const VideoRecordingSubmit();

        case RoutePaths.tutorPortal:
          return const TutorMainScreen();

        case RoutePaths.workoutBankScreen:
          return const WorkoutBankScreen();

        case RoutePaths.myBatchesScreen:
          return const MyBatchesScreen();

        case RoutePaths.myStudentsScreen:
          return const MyStudentsScreen();

        case RoutePaths.studentListScreen:
          return const StudentListScreen();

        case RoutePaths.reviewStudentScreen:
          return ReviewStudentScreen(
            data: settings.arguments,
          );

        case RoutePaths.assignWorkoutScreen:
          return AssignWorkoutScreen(
            data: settings.arguments,
          );

        case RoutePaths.manageSubmissionScreen:
          return const ManageSubmissionScreen();

        case RoutePaths.assignProceedingScreen:
          return AssignProceedingScreen(
            userData: (settings.arguments as Map<String, dynamic>)['userData'],
            homeworkData: (settings.arguments as Map<String, dynamic>)['homeworkData'],
          );

        case RoutePaths.submissionDetailsScreen:
          return const SubmissionDetails();

        case RoutePaths.sendFeedbackScreen:
          return const SendFeedback();

        default:
          return const OnBoardingScreen();
      }
    },
  );
}