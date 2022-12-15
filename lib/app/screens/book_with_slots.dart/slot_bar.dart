import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/colors.dart';

class SlotBar extends StatefulWidget {
  final int activeIndex;
  final void Function(String) updateCallback;
  const SlotBar({
    Key? key,
    required this.activeIndex,
    required this.updateCallback,
  }) : super(key: key);

  @override
  State<SlotBar> createState() => _SlotBarState();
}

class _SlotBarState extends State<SlotBar> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    activeIndex = widget.activeIndex;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SlotCard(
            text: '10-11 AM',
            selected: widget.activeIndex == 0,
            updateCallback: widget.updateCallback,
          ),
          SlotCard(
            text: '1-2 PM',
            selected: widget.activeIndex == 1,
            updateCallback: widget.updateCallback,
          ),
          SlotCard(
            text: '5-6 PM',
            selected: widget.activeIndex == 2,
            updateCallback: widget.updateCallback,
          ),
          SlotCard(
            text: '8-9 PM',
            selected: widget.activeIndex == 3,
            updateCallback: widget.updateCallback,
          ),
        ],
      ),
    );
  }
}

class SlotCard extends StatefulWidget {
  final String text;
  final bool selected;
  final void Function(String) updateCallback;

  const SlotCard({
    Key? key,
    required this.text,
    required this.selected,
    required this.updateCallback,
  }) : super(key: key);

  @override
  State<SlotCard> createState() => _SlotCardState();
}

class _SlotCardState extends State<SlotCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    selected = widget.selected;
    return InkWell(
      onTap: () => widget.updateCallback(widget.text),
      child: Container(
        width: 68.w,
        padding: EdgeInsets.symmetric(
          vertical: 4.w,
        ),
        margin: EdgeInsets.only(
          right: 18.w,
        ),
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).colorScheme.secondary
              : ThemeColors.transparent,
          border: Border.all(
            color: ThemeColors.grey,
          ),
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.button?.copyWith(
                color: selected ? ThemeColors.white : ThemeColors.black,
              ),
        ),
      ),
    );
  }
}
