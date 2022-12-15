import 'dart:developer';
import 'dart:math' show min;

import 'package:audioplayers/audioplayers.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/colors.dart';
import '../fake_data/quiz.dart';
import '../models/quiz.dart';
import '../widgets/training_failure.dart';
import '../widgets/training_success.dart';

class EarTrainingScreen extends StatefulWidget {
  const EarTrainingScreen({Key? key}) : super(key: key);

  @override
  State<EarTrainingScreen> createState() => _EarTrainingScreenState();
}

class _EarTrainingScreenState extends State<EarTrainingScreen> {
  late final Quiz quiz;
  late final int totalQuestions;
  late AudioCache _audioCache;
  int correctlyAnswered = 0;
  int solvedQuestions = 0;

  bool isNote1Active = false;
  bool isNote2Active = false;
  final AudioPlayer _audioplayer = AudioPlayer();
  bool buttonsActive = true;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _audioCache =
        AudioCache(fixedPlayer: _audioplayer, prefix: 'assets/audio/');
    quiz = fakeQuiz;
    totalQuestions = fakeQuiz.noOfQuestions;
    playNotes(quiz.questionsAndAnswers[solvedQuestions]);
    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  Future<void> playNotes(QuizQuestion question) async {
    setState(() {
      buttonsActive = false;
      isNote1Active = true;
    });
    var res1 = await _audioCache.play(question.note1);
    log(res1.toString());
    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      isNote1Active = false;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isNote2Active = true;
    });
    await Future.delayed(const Duration(milliseconds: 300));

    var res2 = await _audioCache.play(question.note2);
    log(res2.toString());
    setState(() {
      isNote1Active = false;
      isNote2Active = false;
      buttonsActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.buttonDarkColor,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12),
        child: Stack(
          children: [
            SingleChildScrollView(

              child: (totalQuestions == solvedQuestions)
                  ? (correctlyAnswered >= 3)
                      ? EarTrainingSuccess(
                          correct: correctlyAnswered,
                          total: totalQuestions,
                        )
                      : EarTrainingFailure(
                          correct: correctlyAnswered,
                          total: totalQuestions,
                        )
                  : Column(
                      children: [
                        DotsIndicator(
                          dotsCount: totalQuestions,
                          position: min(
                            totalQuestions.toDouble() - 1,
                            solvedQuestions.toDouble(),
                          ),
                          decorator: DotsDecorator(
                            activeColor: ThemeColors.brightGold,
                            color: ThemeColors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 24.h),
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            quiz.questionsAndAnswers[solvedQuestions].question,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: ThemeColors.white),
                          ),
                        ),
                        SizedBox(height: 36.h),
                        if (solvedQuestions != totalQuestions)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (buttonsActive) {
                                    if (quiz
                                            .questionsAndAnswers[
                                                solvedQuestions]
                                            .answer ==
                                        '1') {
                                      correctlyAnswered++;
                                    }
                                    setState(() {
                                      solvedQuestions++;
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    if (solvedQuestions < totalQuestions) {
                                      await playNotes(quiz.questionsAndAnswers[
                                          solvedQuestions]);
                                    }
                                  }
                                },
                                child: Container(
                                  height: 100.h,
                                  width: 100.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.w),
                                    color: isNote1Active
                                        ? ThemeColors.accentColor
                                        : ThemeColors.white,
                                  ),
                                  child: Text(
                                    'A',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                            color:
                                                ThemeColors.textPrimaryColor),
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.green,
                                borderRadius: BorderRadius.circular(8.w),
                                onTap: () async {

                                  if (buttonsActive) {
                                    if (quiz
                                            .questionsAndAnswers[
                                                solvedQuestions]
                                            .answer ==
                                        '2') {
                                      correctlyAnswered++;
                                    }
                                    setState(() {
                                      solvedQuestions++;
                                    });
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    if (solvedQuestions < totalQuestions) {
                                      await playNotes(quiz.questionsAndAnswers[
                                          solvedQuestions]);
                                    }
                                  }
                                },
                                child: Container(
                                  height: 100.h,
                                  width: 100.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.w),
                                    color: isNote2Active
                                        ? ThemeColors.accentColor
                                        : ThemeColors.white,
                                  ),
                                  child: Text(
                                    'B',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                            color:
                                                ThemeColors.textPrimaryColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        SizedBox(
                          height: 36.h,
                        ),
                        IconButton(
                          color: ThemeColors.white,
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (buttonsActive) {
                              playNotes(
                                  quiz.questionsAndAnswers[solvedQuestions]);
                            }
                          },
                          icon: Icon(
                            Icons.refresh,
                            size: 50.h,
                          ),
                        ),
                      ],
                    ),
            ),
            if (solvedQuestions < totalQuestions)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                child: IconButton(
                  onPressed: () {
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.fast_rewind_rounded,
                    color: ThemeColors.white,
                    size: 60.h,
                  ),
                ),
              ),
            if (solvedQuestions < totalQuestions)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                right: 8.w,
                child: IconButton(
                  onPressed: () {

                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.fast_forward_rounded,
                    color: ThemeColors.white,
                    size: 60.h,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
