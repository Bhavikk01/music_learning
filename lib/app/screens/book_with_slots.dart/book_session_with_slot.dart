
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../data/controllers/course_controller.dart';
import '../../data/controllers/sessions_controller.dart';
import '../../data/controllers/tutor_controller.dart';
import '../../models/course.dart';
import '../../models/enums/subject.dart';
import '../../models/tutors.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/large_book_button.dart';
import 'session_booking_sucess_screen.dart';
import 'slot_bar.dart';

class BookSessionScreen extends StatefulWidget {
  const BookSessionScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BookSessionScreen> createState() => _BookSessionScreenState();
}

class _BookSessionScreenState extends State<BookSessionScreen> {
  bool isLoading = false;
  List<Tutor> tutors = [];
  List<Subject> subjects = [
    Subject.guitar,
    Subject.bass,
    Subject.flute,
    Subject.piano,
    Subject.tabla,
    Subject.violin,
    Subject.vocal,
  ];
  List<Course> courses = [];
  List<Tutor> allTutors = [];

  int activeSlotIndex = -1;
  Tutor? selectedTutor;
  Subject activeSubject = Subject.guitar;

  var _selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var _focusedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  getTutors() async {
    setState(() {
      isLoading = true;
    });
    courses = await Get.find<CourseController>().getAllCourse();
    allTutors = await Get.find<TutorController>().getAllTutors();

    tutors = allTutors
        .where(
          (tutor) => courses.any((course) =>
              (course.currentTutorId == tutor.id) && (course.slotsLeft! > 0)),
        ).toList();

    selectedTutor = tutors.first;
    activeSubject = selectedTutor!.subjectsTaught!.first;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getTutors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.bookSession,
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                fontSize: 24.sp,
                color: ThemeColors.buttonDarkColor,
              ),
        ),
        leading: BackButton(
          color: ThemeColors.buttonDarkColor,
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 24.w),
        child: (!isLoading)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDropDown(
                    text: Constants.selectCourse,
                    activeData: activeSubject,
                    data: subjects,
                    updateCallback: (subject) => setState(() {
                      activeSubject = subject;
                      tutors = allTutors
                          .where(
                            (tutor) => courses.any((course) =>
                                (course.currentTutorId == tutor.id) &&
                                (course.subject == activeSubject) &&
                                (course.slotsLeft! > 0)),
                          )
                          .toList();
                    }),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomDropDown(
                    text: Constants.selectTutor,
                    data: tutors,
                    updateCallback: (tutor) => setState(() {
                      selectedTutor = tutor;

                    }),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  TableCalendar(
                    calendarFormat: CalendarFormat.week,
                    focusedDay: _focusedDay,
                    firstDay: DateTime.now(),
                    lastDay: DateTime(2100),
                    daysOfWeekHeight: 60,
                    availableCalendarFormats: const {
                      CalendarFormat.week: 'Week'
                    },
                    locale: 'en-IN',
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                    ),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                    calendarBuilders: CalendarBuilders(
                      dowBuilder: (context, day) {
                        return Center(
                          child: Text(
                            getDayNameFromInt(day.weekday).substring(0, 1),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    Constants.availableSlots,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  SlotBar(
                    activeIndex: activeSlotIndex,
                    updateCallback: (text) {
                      switch (text) {
                        case '10-11 AM':
                          activeSlotIndex = 0;
                          break;

                        case '1-2 PM':
                          activeSlotIndex = 1;
                          break;

                        case '5-6 PM':
                          activeSlotIndex = 2;
                          break;

                        case '8-9 PM':
                          activeSlotIndex = 3;
                          break;

                        default:
                          activeSlotIndex = 0;
                          break;
                      }

                      if (mounted) setState(() {});
                    },
                  ),
                  const Spacer(),
                  LargeBookButton(
                    title: Constants.bookSession,
                    onTap: () async {
                      if (activeSlotIndex == -1) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Select a slot')));
                        return;
                      }
                      var time = activeSlotIndex == 0
                          ? 10
                          : activeSlotIndex == 1
                              ? 13
                              : activeSlotIndex == 2
                                  ? 17
                                  : 20;

                      var startTime = DateTime(
                        _selectedDay.year,
                        _selectedDay.month,
                        _selectedDay.day,
                        time,
                      );
                      await Get.find<SessionController>().bookSession(
                        selectedTutor!.id!,
                        activeSubject,
                        startTime,
                      );
                      await Navigator.push(context, MaterialPageRoute(builder: (_) => const SessionBookingSuccessScreen()));
                    },
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
