import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../data/API/api_client.dart';
import '../../hive_database/database_repository.dart';
import '../../models/enums/hobby.dart';
import '../home_screens/screens/homePage.dart';


class CoursePreferenceScreen extends StatelessWidget {
  const CoursePreferenceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 36.w,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              Constants.preference,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () async {
                final user = DataBaseRepository.getUser()
                    .copyWith(currentPreferedHobby: Hobby.music.value);
                await ApiClient().updateUser(user);

                await Navigator.push(context, MaterialPageRoute(builder: (_)=> const HomePage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeColors.accentColor,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                height: 150.h,
                width: double.infinity,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.w,
                    ),
                    Text(
                      Constants.music,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    Icon(
                      Icons.music_note,
                      color: ThemeColors.white,
                      size: 80,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final user = DataBaseRepository.getUser()
                    .copyWith(currentPreferedHobby: Hobby.dance.value);
                await ApiClient().updateUser(user);

                await Navigator.push(context, MaterialPageRoute(builder: (_)=> const HomePage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ThemeColors.accentColor,
                  borderRadius: BorderRadius.circular(20.w),
                ),
                height: 150.h,
                width: double.infinity,
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.w,
                    ),
                    Text(
                      Constants.dance,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      width: 90.w,
                    ),
                    Icon(
                      Icons.music_video,
                      color: ThemeColors.white,
                      size: 80,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
