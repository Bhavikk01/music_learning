import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../../../constants/route_paths.dart';
import '../../../utils/utils.dart';

class Explore extends StatelessWidget {
  const Explore({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Constants.courses,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(RoutePaths.courseScreen),
                    child: Text(
                      Constants.viewAll,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2
                          ?.copyWith(decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 230.h,
                child: CarouselSlider(
                  items: Constants.subjectsMap.keys
                      .map((subject) => GestureDetector(
                            onTap: () => Get.toNamed(
                              RoutePaths.subjectScreen,
                              arguments: subject,
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.w)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(
                                        Constants.subjectsMap[subject] ??
                                            Constants.guitarImagePath,
                                        fit: BoxFit.cover,
                                        width: 1000,
                                      ),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 10.0,
                                            horizontal: 20.0,
                                          ),
                                          child: Text(
                                            capitalize(subject.name),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    disableCenter: true,
                    viewportFraction: 0.5,
                  ),
                ),
              ),
              SizedBox(
                height: 45.h,
              ),
              Text(
                Constants.discover,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 15.h,
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 208.h,
                    width: 277.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: ThemeColors.milkyWhite,
                      boxShadow: [
                        BoxShadow(
                          color: ThemeColors.shadowColorBluish,
                          offset: const Offset(-9.797174820681343e-16, 11),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200.h,
                    width: 300.w,
                    decoration: BoxDecoration(
                      color: ThemeColors.fadedBlue,
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                  ),
                  Container(
                    height: 193.h,
                    width: 338.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      gradient: LinearGradient(
                        begin: const Alignment(-2.18, 0.0),
                        end: const Alignment(0.41, 0.0),
                        colors: ThemeColors.linearGradientColors,
                        stops: const [0.0, 1.0],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                          '20% off!',
                          style:
                              Theme.of(context).textTheme.headline2?.copyWith(
                                    color: ThemeColors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 70,
                                  ),
                        ),
                        Text(
                          'Offers, Ads, etc (card stock)',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
