import 'dart:developer';

import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../models/tutors.dart';
import '../../widgets/star_rating_widget.dart';
import 'tutor_review.dart';

class TutorDetailExpansionWidget extends StatefulWidget {
  final Tutor tutor;
  const TutorDetailExpansionWidget({Key? key, required this.tutor})
      : super(key: key);

  @override
  State<TutorDetailExpansionWidget> createState() =>
      _TutorDetailExpansionWidgetState();
}

class _TutorDetailExpansionWidgetState extends State<TutorDetailExpansionWidget> {
  List<bool> expanded = List.filled(2, true);

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      dividerColor: ThemeColors.transparent,
      elevation: 0,
      expansionCallback: (panelIndex, isExpanded) => setState(() {
        expanded[panelIndex] = !isExpanded;
      }),
      children: [
        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (context, open) {
            return Row(
              children: [
                Text(
                  Constants.about,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ThemeColors.textPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Expanded(
                  child: Divider(
                    indent: 10.0,
                    endIndent: 20.0,
                    thickness: 1,
                    color: ThemeColors.grey.withOpacity(0.5),
                  ),
                ),
              ],
            );
          },
          body: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.tutor.description ?? Constants.emptySpace,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
          isExpanded: expanded[0],
        ),
        ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (context, open) {
            return Row(
              children: [
                Text(
                  Constants.reviews,
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: ThemeColors.textPrimaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Expanded(
                  child: Divider(
                    indent: 10.0,
                    endIndent: 20.0,
                    thickness: 1,
                    color: ThemeColors.grey.withOpacity(0.5),
                  ),
                ),
              ],
            );
          },
          body: Column(
            children: [
              TutorReview(
                imagePath: widget.tutor.imageUrl!,
                name: widget.tutor.name!,
                ratingWidget: const StarRatingWidget(rating: 3.4),
                review: 'sfjkla;s;jsghjslgkshk',
              ),
              TutorReview(
                imagePath: widget.tutor.imageUrl!,
                name: widget.tutor.name!,
                ratingWidget: const StarRatingWidget(rating: 3.4),
                review: 'sfjkla;s;jsghjslgkshk',
              ),
              TutorReview(
                imagePath: widget.tutor.imageUrl!,
                name: widget.tutor.name!,
                ratingWidget: const StarRatingWidget(rating: 3.4),
                review: 'sfjkla;s;jsghjslgkshk',
              ),
            ],
          ),
          isExpanded: expanded[1],
        ),
      ],
    );
  }
}
