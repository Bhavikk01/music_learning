import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import '../../constants/route_paths.dart';
import '../../widgets/audio_preview.dart';
import '../../widgets/main_button.dart';

class SubmissionDetails extends StatefulWidget {
  const SubmissionDetails({Key? key}) : super(key: key);

  @override
  State<SubmissionDetails> createState() => _SubmissionDetailsState();
}

class _SubmissionDetailsState extends State<SubmissionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubmissionAppBar(title: 'Sidhhant Sinha', context: context, workoutName: 'Fur Elise',),
      body: Column(
        children: [
          Expanded(child: GridView.count(crossAxisCount: 3, children: const [
            PlayButton(title: 'Submission 1'),
            PlayButton(title: 'Submission 2'),
            PlayButton(title: 'Submission 3'),
          ],)),
          Padding(padding: const EdgeInsets.all(20), child: MainButton(title: 'Mark as Reviewed', onPressed: (){
            Navigator.of(context).pushNamed(RoutePaths.sendFeedbackScreen);
          }))
        ]
      ),
    );
  }
}


class SubmissionAppBar extends AppBar {

  SubmissionAppBar(
      {Key? key, required String title, String? workoutName, String? assignedOn, String? deadline, String? submittedOn, String? submissions, required BuildContext context})
      : super(key: key,
      automaticallyImplyLeading: false,
      backgroundColor: Constants.themePrimary,
      foregroundColor: ThemeColors.white,
      toolbarHeight: 220,
      centerTitle: true,
      title: workoutName==null ? Text(title, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white))
          : Padding(padding: const EdgeInsets.symmetric(horizontal: 40),child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white)),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Workout Name', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
            Text(workoutName, style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Assigned On', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
            Text('$assignedOn', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Deadline', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
            Text('$deadline', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Submitted On', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
            Text('$submittedOn', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
          ],),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text('Submissions', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white, fontWeight: FontWeight.w700)),
            Text('$submissions', style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.white),),
          ],),
        ],))
  );
}

class PlayButton extends StatefulWidget {
  const PlayButton({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {

  bool play = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20,),
        play?const AudioBarSeries(isAnimated: false,heights: [30, 40,20,30,],):InkWell(child:Image.asset('assets/reviewplay.png', height: 40,), onTap: (){
          setState(() {
            play = true;
          });
        },),
        const SizedBox(height: 20,),
        Text(widget.title, style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.black, fontWeight: FontWeight.w700),)
      ],
    );
  }
}



