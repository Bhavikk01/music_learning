// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';
import '../../constants/route_paths.dart';

class WorkoutBookingSuccessScreen extends StatelessWidget {

  final userData;

  const WorkoutBookingSuccessScreen({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(
          context,
          ModalRoute.withName(RoutePaths.homeScreen),
        );
        return Future.value(true);
      },
      child: Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 24.h,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
              ),
              SvgPicture.asset(
                Constants.successImagePath,
                height: 300,
              ),
              Text(
                Constants.success,
                style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () => {Navigator.popUntil(context, ModalRoute.withName(RoutePaths.studentListScreen))},
                  style: ButtonStyle(

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => const Color(0xff0A5470))
                  ),
                  child:  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      'Assign workout to a Varun',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                      ),),
                  )),
              ElevatedButton(
                  onPressed: () => {Navigator.popUntil(context, ModalRoute.withName(RoutePaths.studentListScreen))},
                  style: ButtonStyle(

                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                          )),
                      backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white)
                  ),
                  child:  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Text(
                      'Assign workout to a different student',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'Poppins',
                      ),),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
