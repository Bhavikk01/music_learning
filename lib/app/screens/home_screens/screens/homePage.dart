// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../profile/profile_screen.dart';
import '../../tutor_portal/main_screen.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late PersistentTabController _controller;
  bool answer = false;

  List <Widget> _buildScreen() {
    // loadTutorCheck();
    return [
      const HomeScreen(index: 0),
      answer
          ? const TutorMainScreen()
          : const HomeScreen(index: 0),
      const ProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/images/home.svg',
          ),
          title: 'Explore'
      ),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/images/categories.svg',
          ),
          title: 'Learn'
      ),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            'assets/images/ellipse.svg',
          ),
          title: 'Profile'
      )
    ];
  }

  // Future<void> loadTutorCheck() async{
  //   var preferences = await SharedPreferences.getInstance();
  //   setState((){
  //   answer = (preferences.getBool('isTutor'))!;
  //   });
  // }

  @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  void onTapNav(int index){
    setState((){
    });
  }

  @override
  Widget build(BuildContext context) {

    return PersistentTabView(
      context,
      screens: _buildScreen(),
      items: _navBarItems(),
      controller: _controller,
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(20.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
