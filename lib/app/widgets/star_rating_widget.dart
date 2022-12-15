import 'package:flutter/material.dart';
import '../config/colors.dart';

class StarRatingWidget extends StatelessWidget {
  final num rating;
  const StarRatingWidget({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fullRate = rating.floor();
    var remaining = rating != fullRate;

    return Row(
      children: [
        ...List<Widget>.filled(
          fullRate,
          Icon(
            Icons.star,
            color: ThemeColors.brightGold,
            size: 20,
          ),
        ),
        if (remaining)
          Icon(
            Icons.star_half_rounded,
            color: ThemeColors.brightGold,
            size: 20,
          ),
      ],
    );
  }
}
