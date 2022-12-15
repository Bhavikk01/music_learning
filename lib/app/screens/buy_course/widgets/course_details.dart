import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/constants.dart';
import '../../../models/enums/pricing_plan.dart';

class CourseDetails extends StatelessWidget {
  late final int price;
  final PricingPlan plan;
  CourseDetails({
    Key? key,
    required this.plan,
  }) : super(key: key) {
    price = Constants.pricingTiles[plan]!['price'] as int;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subtotal',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              '₹ $price',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tax',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              '₹ ${(price / 9).round()}',
              style: Theme.of(context).textTheme.subtitle2,
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
              'Total',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              '₹ ${price + (price / 9).round()}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ],
    );
  }
}
