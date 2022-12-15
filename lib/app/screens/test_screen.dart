// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/audio_preview.dart';


class TestScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _TestScreenState();

}

class _TestScreenState extends State<TestScreen> with SingleTickerProviderStateMixin{
  List<double> heights = [40, 30, 20, 50, 30, 45, 20];
  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: kThemeAnimationDuration*10);
    () async {
      await Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          heights = [23, 43, 43, 52, 53, 34, 25, 65, 34, 23, 4];
        });
      });
      await Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          heights = [23, 43, 43, 52, 53, 34, 25, 65, 34];
        });
      });
      await Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          heights = [3, 23, 43, 52, 34, 25, 65, 34, 23, 30];
        });
      });
      await Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          heights = [53, 23,  52, 35, 44, 25, 8, 34, 43, 20];
        });
      });
      await Future.delayed(const Duration(seconds: 5), ()async{
        await (controller
          ..addListener(() {
            setState(() {
              heights = List.generate(10, (index)=>25*pow(cos(controller.value*2*pi+2*pi/10*index), 2)+25);
            });
          }))
          .animateTo(5.0);
      });
    }();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AudioBarSeries(heights: heights)
    );
  }
}