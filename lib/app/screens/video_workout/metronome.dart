import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';

class EmbeddedMetronome extends StatefulWidget {
  const EmbeddedMetronome({Key? key}) : super(key: key);

  @override
  State<EmbeddedMetronome> createState() => _EmbeddedMetronomeState();
}

class _EmbeddedMetronomeState extends State<EmbeddedMetronome> {

  bool isPlaying = false;
  int bpm = 90;

  @override
  Widget build(BuildContext context) {
    return Column(children:[Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(Constants.minus),
        isPlaying?SvgPicture.asset(Constants.pause):SvgPicture.asset(Constants.playIcon),
        SvgPicture.asset(Constants.plus)
      ],
    ),
      Text('$bpm BPM', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: ThemeColors.grey),)
        ]);
  }
}
