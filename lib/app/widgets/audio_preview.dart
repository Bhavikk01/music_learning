import 'dart:math';
import 'package:flutter/material.dart';


class AudioBarSeries extends StatefulWidget {

  final List<double> heights;
  final bool isAnimated;

  const AudioBarSeries({Key? key, required this.heights, this.isAnimated=true}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AudioBarSeriesState();
  }
}

class _AudioBarSeriesState extends State<AudioBarSeries> with SingleTickerProviderStateMixin{
  late AnimationController controller;
  late List<double> fromHeights;
  late List<double> currentHeights;

  @override
  void initState() {
    currentHeights = widget.heights.map((e) => 0.0).toList();
    controller = AnimationController(duration: kThemeAnimationDuration, vsync: this);
    if(!widget.isAnimated){
      fromHeights = List.from(widget.heights);
    } else {
      fromHeights = widget.heights.map((e) => 0.0).toList();
    }
    controller
      ..addListener(() {setState(() {
        for(var i=0; i<max(widget.heights.length, fromHeights.length); i++){
          if(i<widget.heights.length) {
            currentHeights[i] = fromHeights[i] * (1 - controller.value) +
                widget.heights[i] * controller.value;
          }else{
            currentHeights[i] = fromHeights[i] * (1 - controller.value);
          }
        }
      });})
      ..animateTo(1, curve: Curves.easeInOut);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AudioBarSeries oldWidget) {
    if (oldWidget.heights.length < widget.heights.length) {
      fromHeights = oldWidget.heights + List.generate(
          widget.heights.length - oldWidget.heights.length, (index) => 0.0);
      currentHeights.addAll(List.generate(
          widget.heights.length - oldWidget.heights.length, (index) => 0.0));
    } else {
      fromHeights = oldWidget.heights;
    }
    controller
      ..value = 0.0
      ..animateTo(1.0, curve: Curves.easeInOut).then((value) {
        setState(() {
          currentHeights = currentHeights.sublist(0, widget.heights.length);
        });
      });
    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    var series = <Widget>[];
    for(var height in currentHeights){
      series.add(AudioBar(height: height));
    }
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: series
    );
  }

  @override
  void dispose() {
    controller
      ..removeListener(() {setState(() {});})
      ..dispose();
    super.dispose();
  }
}

class AudioBar extends Container {
  AudioBar({Key? key, required double height, Color color=Colors.greenAccent}) :super(key: key,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10)
      )
  );
}