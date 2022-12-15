import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constants.dart';
import '../../widgets/star_rating_widget.dart';

class TutorReview extends StatelessWidget {
  final String imagePath;
  final String name;
  final StarRatingWidget ratingWidget;
  final String review;

  const TutorReview({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.ratingWidget,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipOval(
                child: (imagePath.contains('drive') ||
                        !imagePath.startsWith('http'))
                    ? Image.asset(
                        Constants.tutorImagePath,
                        width: 40.w,
                        height: 40.w,
                      )
                    : CachedNetworkImage(
                        imageUrl: imagePath,
                        placeholder: (context, str) {
                          return Container(
                            child: Text(str),
                            color: Colors.red,
                          );
                        },
                        fit: BoxFit.cover,
                        width: 40.w,
                        height: 40.w,
                      ),
              ),
              SizedBox(
                width: 12.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  ratingWidget,
                ],
              )
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            review,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
