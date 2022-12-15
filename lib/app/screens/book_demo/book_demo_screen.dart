import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../data/API/api_client.dart';
import '../../hive_database/database_repository.dart';
import '../../models/enums/subject.dart';
import '../../models/tutors.dart';
import '../../utils/utils.dart';
import '../../widgets/custom_textfield.dart';

class BookDemoScreen extends StatefulWidget {
  final Tutor tutor;
  final Subject subject;
  final DateTime slot;

  const BookDemoScreen({
    Key? key,
    required this.tutor,
    required this.subject,
    required this.slot,
  }) : super(key: key);

  @override
  State<BookDemoScreen> createState() => _BookDemoScreenState();
}

class _BookDemoScreenState extends State<BookDemoScreen> {
  String name = '';
  String email = '';
  bool hasInstrument = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          color: ThemeColors.textDarkColor,
        ),
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Text(
                    Constants.bookDemo,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  width: 308.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ThemeColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.w),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.grey.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    capitalize(widget.subject.name),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ThemeColors.textLightColor,
                        ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  width: 308.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ThemeColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.grey.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.tutor.name ?? Constants.tutor,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ThemeColors.textLightColor,
                        ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextField(
                  hintText: Constants.name,
                  inputType: TextInputType.text,
                  style: Theme.of(context).textTheme.bodyText2,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                CustomTextField(
                  hintText: Constants.email,
                  inputType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyText2,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  width: 308.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ThemeColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.grey.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DataBaseRepository.getUser().mobile,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ThemeColors.textLightColor,
                        ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  width: 308.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: ThemeColors.grey.withOpacity(0.2),
                    border: Border.all(
                      width: 1,
                      color: ThemeColors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.grey.withOpacity(0.2),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat.jm().format(widget.slot),
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ThemeColors.textLightColor,
                        ),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: hasInstrument,
                      onChanged: (val) => setState(
                        () {
                          hasInstrument = val ?? false;
                        },
                      ),
                    ),
                    Text(
                      'Do you already own an instrument?',
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: ThemeColors.textPrimaryColor,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                ElevatedButton(
                  onPressed: (name == '' || email == '')
                      ? null
                      : () async {
                          if (!Email.validate(email)) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(Constants.invalidEmail),
                            ));
                          } else if (name.length < 3) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Name should be atleast 3 characters',
                                ),
                              ),
                            );
                          } else {
                            await ApiClient().updateUser(
                              DataBaseRepository.getUser().copyWith(
                                name: name,
                                emailId: email,
                              ),
                            );
                            await ApiClient().bookDemoSession(
                              widget.tutor,
                              widget.slot,
                              widget.subject,
                            );
                            await showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  content: SizedBox(
                                    height: 200.h,
                                    child: Center(
                                      child: Text(
                                        Constants.bookDemoConfirmation,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 36.w,
                                          vertical: 8.h,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.w),
                                        ),
                                      ),
                                      onPressed: () => Get.toNamed(
                                        RoutePaths.homeScreen,
                                        arguments: 1,
                                      ),
                                      child: const Text('Continue'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                  child: Text(
                    Constants.book,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: ThemeColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 36.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.w),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
