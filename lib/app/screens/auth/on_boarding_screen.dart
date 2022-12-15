import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../config/colors.dart';
import '../../constants/constants.dart';
import 'auth_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(
      Constants.bgVideoPath,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    )..initialize().then((_) {
        _controller
          ..play()
          ..setLooping(true)
          ..setVolume(0);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 36.0,
              horizontal: 12.0,
            ),
            child: Column(
              children: [
                const Spacer(),
                Text(
                  Constants.introPageTitle,
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: ThemeColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const SignInScreen()));

                  },
                  child: const Text(Constants.signIn),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    minimumSize: const Size.fromHeight(
                      40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
