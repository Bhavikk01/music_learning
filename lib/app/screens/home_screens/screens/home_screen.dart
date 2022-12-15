import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/colors.dart';
import '../../../constants/constants.dart';
import '../widgets/utilities_screen.dart';
import 'explore_screen.dart';
import 'my_learning_screen.dart';

class HomeScreen extends StatefulWidget {
  final int index;
  const HomeScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  DateTime currentBackPressTime = DateTime.now();
  late final TabController _controller;

  @override
  void initState() {

    _controller = TabController(length: 3, vsync: this);

    _controller.animation?.addListener(() {
      setState((){});
    });

    _controller.animateTo(widget.index);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              Constants.learn,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            elevation: 0,
            bottom: PreferredSize(
              child: TabBar(
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorColor: ThemeColors.transparent,
                controller: _controller,
                tabs: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _controller.animation?.value.round() == 0
                          ? Theme.of(context).colorScheme.secondary
                          : ThemeColors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      Constants.explore,
                      style: TextStyle(
                        fontSize: 14,
                        color: _controller.animation?.value.round() == 0
                            ? ThemeColors.white
                            : ThemeColors.textPrimaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _controller.animation?.value.round() == 1
                          ? Theme.of(context).colorScheme.secondary
                          : ThemeColors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      Constants.myLearning,
                      style: TextStyle(
                        fontSize: 14,
                        color: _controller.animation?.value.round() == 1
                            ? ThemeColors.white
                            : ThemeColors.textPrimaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _controller.animation?.value.round() == 2
                          ? Theme.of(context).colorScheme.secondary
                          : ThemeColors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      Constants.utilities,
                      style: TextStyle(
                        fontSize: 14,
                        color: _controller.animation?.value.round() == 2
                            ? ThemeColors.white
                            : ThemeColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              preferredSize: Size.fromHeight(36.h),
            ),
          ),

          body: TabBarView(
            controller: _controller,
            children: const [
              Explore(),
              MyLearningScreen(),
              UtilitiesScreen(),
            ],
          ),
        );
  }
}
