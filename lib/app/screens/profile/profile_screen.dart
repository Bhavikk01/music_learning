import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../hive_database/database_repository.dart';
import 'account.dart';
import 'payment_tab.dart';
import 'privacy_policy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

            body: Column(
              children: [
                SizedBox(
                  height: 320.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 90.h,
                      ),
                      CircleAvatar(
                        radius: 60.h,
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        DataBaseRepository.getUser().name ?? 'Mohit Singh',
                        style: Theme.of(context).textTheme.headline5,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                  child: TabBar(
                    padding: EdgeInsets.only(right: 50.w),
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: ThemeColors.grey,
                    unselectedLabelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 14.sp),
                    labelStyle: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 14.sp),
                    labelColor: ThemeColors.accentColor,
                    tabs: const [
                      Tab(
                        text: Constants.account,
                      ),
                      Tab(
                        text: Constants.payment,
                      ),
                      Tab(
                        text: Constants.policy,
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      AccountTab(),
                      PaymentTab(),
                      PrivacyPolicyTab(),
                    ],
                  ),
                ),
              ],
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //   type: BottomNavigationBarType.fixed,
            //   // showSelectedLabels: false,
            //   // showUnselectedLabels: false,
            //   currentIndex: _currentIndex,
            //   onTap: (index){
            //
            //     setState((){
            //       _currentIndex = index;
            //     });
            //
            //     if(_currentIndex == 0){
            //       Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
            //     }else if(_currentIndex == 1){
            //       Navigator.pushReplacementNamed(context, RoutePaths.homeScreen);
            //     }else if(_currentIndex == 2){
            //       Navigator.pushReplacementNamed(context, RoutePaths.profileScreen);
            //     }
            //   },
            //   items: [
            //     BottomNavigationBarItem(
            //       label: 'Explore',
            //       icon: SvgPicture.asset(
            //         'assets/images/home.svg',
            //         color: _currentIndex == 0
            //             ? Theme.of(context).colorScheme.secondary
            //             : ThemeColors.grey,
            //       ),
            //     ),
            //     BottomNavigationBarItem(
            //       label: 'Learn',
            //       icon: SvgPicture.asset(
            //         'assets/images/categories.svg',
            //         color: _currentIndex == 1
            //             ? Theme.of(context).colorScheme.secondary
            //             : ThemeColors.grey,
            //       ),
            //     ),
            //     BottomNavigationBarItem(
            //       label: 'Profile',
            //       icon: SvgPicture.asset(
            //         'assets/images/ellipse.svg',
            //         color: _currentIndex == 2
            //             ? Theme.of(context).colorScheme.secondary
            //         : Colors.grey,
            //       ),
            //     ),
            //   ],
            // ),
          ),
    );
  }
}
