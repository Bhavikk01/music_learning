import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../data/controllers/course_controller.dart';
import '../../../data/controllers/homework_controller.dart';
import '../../../data/controllers/sessions_controller.dart';
import '../../../models/enums/learning_card_type.dart';
import '../../../widgets/large_book_button.dart';
import '../widgets/empty_learning.dart';
import '../widgets/learning_card.dart';

class MyLearningScreen extends StatefulWidget {
  const MyLearningScreen({Key? key}) : super(key: key);

  @override
  State<MyLearningScreen> createState() => _MyLearningScreenState();
}

class _MyLearningScreenState extends State<MyLearningScreen> {

  loadUserData() {
    Get.find<SessionController>().getAllSession();
    Get.find<CourseController>().getAllCourse();
    Get.find<HomeworkController>().getAllHomework();
  }

  @override
  void initState() {
    loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeworkController>(builder: (homeworkController) {
          return GetBuilder<SessionController>(builder: (sessionController){
            return GetBuilder<CourseController>(builder: (courseController){
              return SingleChildScrollView(
                child: courseController.courseList.isEmpty &&
                    homeworkController.homeworkList.isEmpty &&
                    sessionController.sessionList.isEmpty
                    ? const EmptyLearningWidget()
                    : Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    if (courseController.courseList.isNotEmpty || courseController.courseList != null)
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        child: LargeBookButton(
                          title: Constants.bookSession,
                          onTap: () => Get.toNamed(
                            RoutePaths.bookSessionScreen,
                          ),
                        ),
                      ),
                    if (sessionController.sessionList.isNotEmpty)
                      LearningCard(
                        data: sessionController.sessionList,
                        learningCardType: LearningCardType.session,
                      ),
                    // if (homeworkController.homeworkList.isNotEmpty)
                      LearningCard(
                        data: homeworkController.homeworkList,
                        learningCardType: LearningCardType.workout,
                      ),
                    if (courseController.courseList.isNotEmpty)
                      LearningCard(
                        data: courseController.courseList,
                        learningCardType: LearningCardType.course,
                      ),
                    // if (courseController.showRating)
                    //   LearningCard(
                    //     learningCardType: LearningCardType.rating,
                    //     ratingCallBack: () => context.read<HomeBloc>().add(
                    //       const HomeUpdateShowRatingEvent(false),
                    //     ),
                    //   ),
                  ],
                ),
              );
            });
          });
        },
      ),
    );
  }

}
