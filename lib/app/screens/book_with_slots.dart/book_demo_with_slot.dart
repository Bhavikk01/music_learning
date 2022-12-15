import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../models/enums/subject.dart';
import '../../models/tutors.dart';
import '../../utils/utils.dart';
import '../../widgets/large_book_button.dart';
import '../book_demo/book_demo_screen.dart';
import 'slot_bar.dart';

class BookDemoWithSlotScreen extends StatefulWidget {
  final Tutor tutor;
  final Subject subject;
  const BookDemoWithSlotScreen({
    Key? key,
    required this.tutor,
    required this.subject,
  }) : super(key: key);

  @override
  State<BookDemoWithSlotScreen> createState() => _BookDemoWithSlotScreenState();
}

class _BookDemoWithSlotScreenState extends State<BookDemoWithSlotScreen> {
  int activeSlotIndex = -1;

  var _selectedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var _focusedDay =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.bookDemo,
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Constants.course,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  capitalize(widget.subject.name),
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Constants.tutor,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  widget.tutor.name ?? Constants.tutor,
                ),
              ],
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
              availableCalendarFormats: const {CalendarFormat.week: 'Week'},
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
              // calendarFormat: _calendarFormat,
              // onFormatChanged: (format) {
              //   setState(() {
              //     _calendarFormat = format;
              //   });
              // },
            ),
            SizedBox(
              height: 24.h,
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
              title: Constants.bookDemo,
              onTap: () {
                if (activeSlotIndex != -1) {
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

                  Navigator.push(context, MaterialPageRoute(builder: (_)=> BookDemoScreen(subject: widget.subject,slot: startTime,tutor: widget.tutor)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Select Slot')));
                }
              },
            ),
            SizedBox(
              height: 12.h,
            ),
          ],
        ),
      ),
    );
  }
}
