import 'package:flutter/material.dart';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:flutter_svg/svg.dart';

class TunerScreen extends StatefulWidget {
  TunerScreen({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  State<TunerScreen> createState() => _TunerScreenState();
}

class _TunerScreenState extends State<TunerScreen>  with SingleTickerProviderStateMixin {

  double? frequency, endPoint = 0.0, beginPoint = 0.0;
  String? note;
  int? octave;
  bool? isRecording, isInit = false;
  late final Color _bodyColor= Colors.white;
  FlutterFft flutterFft = FlutterFft();

  _initialize() async {
    while (!(await flutterFft.checkPermission())) {
      flutterFft.requestPermission();
    }

    try{
      // await flutterFft.checkPermissions();
      await flutterFft.startRecorder();
      setState(() => isRecording = flutterFft.getIsRecording);

      //Tunner logic
      flutterFft.onRecorderStateChanged.listen(
              (data) => {
            setState(
                  () => {
                frequency = data[1] as double,
                note = data[2] as String,
                octave = data[5] as int,
                beginPoint = endPoint,
                endPoint = setEndPoint(),
              },

            ),
            flutterFft.setNote = note!,
            flutterFft.setFrequency = frequency!,
            flutterFft.setOctave = octave!,
          },
          onError: (err) {
            print("not   recording");
          },
          onDone: ()  {print("Isdone");

          });
    }catch (e) {
      _initialize();
    }
  }

  getNote(frequency) {
    if(frequency >= 281.0 && frequency <= 360){
      return [(329.63 - frequency).round(), "E1"];
    }else if(frequency >= 220.00 && frequency <= 280.00) {
      return [(246.94 - frequency).round(), "B2"];
    }
    else if(frequency >= 150.00 && frequency <= 219.00) {
      return [(196.00 - frequency).round(), "G3"];
    }
    else if(frequency >= 125.00  && frequency <= 149.00) {
      return [(146.83 - frequency).round(), "D4"];
    }
    else if(frequency >= 95.00 && frequency <= 124.0) {
      return [(110.00 - frequency).round(), "A5"];
    }else if(frequency >= 50 && frequency <= 94) {
      return [(82.41 - frequency).round(), "E6"];
    }
    return [0.0, 'None'];
  }

  late  AnimationController _controller;

  late  Animation<double> _animation;


  //Setting end point for the needle to be at

  setEndPoint(){
    if(getNote(frequency)[0] > 10){
      return -0.55;
    }
    if(getNote(frequency)[0] < -10){
      return 0.55;
    }
    return getNote(frequency)[0] * -0.055;
  }

  //Animating needle
  animate() {

    if(isInit == false) {
      _controller = AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      )..animateTo(1, curve: Curves.easeIn);

      _animation =
          Tween<double>(begin: beginPoint, end: endPoint).animate(_controller);
      isInit = true;
    }else {
      if(_animation.isCompleted){
        _controller.forward(from: 0.0);
        _animation =
            Tween<double>(begin: beginPoint, end: endPoint).animate(_controller);
      }
    }
  }


  @override
  void initState() {
    isRecording = flutterFft.getIsRecording;
    frequency = flutterFft.getFrequency;
    note = flutterFft.getNote;
    octave = flutterFft.getOctave;


    print(isRecording);
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant TunerScreen oldWidget) {
    // TODO: implement didUpdateWidget
    animate();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {

    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    animate();
    return Scaffold(
          appBar: AppBar(
            leadingWidth: 100,
            title: const Text(
                'Tuner'
            ),
            iconTheme: const IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
          ),
          backgroundColor: _bodyColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                height:  (MediaQuery.of(context).size.height * 0.7),
                width:  MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      child: SvgPicture.asset(
                        'assets/images/meter.svg',
                        color: _bodyColor,
                        colorBlendMode: BlendMode.darken,
                        width:  MediaQuery.of(context).size.width * 0.9,
                      ),
                      top: 130,
                    ),
                    Center(
                      child: AnimatedBuilder(
                        child: const Padding(

                          padding: EdgeInsets.all(8.0),
                          child: VerticalDivider(

                            color: Colors.black,
                            thickness: 2,
                            width: 1,
                            indent: 200,
                            endIndent:160,
                          ),
                        ),

                        builder: (context, child) =>  Transform.rotate(
                            alignment: Alignment(0.0,0.5),
                            angle: -1 * _animation.value,
                            child: child
                        ), animation: _animation,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                getNote(frequency)[0].toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              Text(
                getNote(frequency)[1].toString() == "None" ? "" : getNote(frequency)[1].toString(),
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 64,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
        );
  }
}