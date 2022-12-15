import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/colors.dart';
import '../constants/constants.dart';
import '../models/enums/subject.dart';
import '../models/enums/workout_type.dart';
import '../utils/utils.dart';



class CustomDropDown extends StatefulWidget {
  final List data;
  final void Function(dynamic) updateCallback;
  final String text;
  final dynamic activeData;
  const CustomDropDown({
    Key? key,
    required this.data,
    required this.text,
    required this.updateCallback,
    this.activeData,
  }) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  int index = 0;

  @override
  void initState() {
    log('Here is the value: ${widget.data.length} and $index');
    if (widget.activeData != null) {
      index = widget.data.indexOf(widget.activeData);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 4.h,
            horizontal: 8.w,
          ),
          width: MediaQuery.of(context).size.width * 0.5,
          height: 40.h,
          decoration: BoxDecoration(
            color: ThemeColors.blue,
            borderRadius: BorderRadius.circular(
              12.w,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              value: widget.data.isEmpty ? null : widget.data[index],
              style: Theme.of(context).textTheme.bodyText1,
              isExpanded: true,
              iconEnabledColor: Theme.of(context).colorScheme.secondary,
              iconDisabledColor: Theme.of(context).colorScheme.secondary,
              items: widget.data.isEmpty
                  ? []
                  : widget.data
                      .map(
                        (e) => DropdownMenuItem<dynamic>(
                          child: (e is Subject)
                              ? Text(capitalize(e.name))
                              : Text(e.name ?? Constants.tutor),
                          value: e,
                        ),
                      )
                      .toList(),
              onChanged: (tutor) {
                setState(() {
                  index = widget.data.indexOf(tutor!);
                });
                widget.updateCallback(tutor!);
              },
            ),
          ),
        ),
      ],
    );
  }
}
