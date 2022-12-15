import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import '../widgets/db.dart';
import '../widgets/select_drawer.dart';


class MetronomeScreen extends StatefulWidget {
  MetronomeScreen({Key? key, this.title}) : super(key: key);

  final String? title;
  final Duration duration = const Duration(seconds: 2);

  final aCache = AudioCache(respectSilence: true);

  final Color nextIconColor = Colors.green;

  final int selectedIconFadeInMs = 500;
  final int selectedIconRemainMs = 3000;
  final int selectedIconFadeOutMs = 500;
  final Color selectedIconCorrectColor = Colors.green;
  final Color selectedIconWrongColor = Colors.red;

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MetronomeScreen>
    with SingleTickerProviderStateMixin {

  bool _metronome_playing = false;




  var tempo = 30;
  var tempoCustom = false;
  var beat1 = 4;
  var beat2 = 4;
  var beat_count = 0;
  var rhythm = 0;
  var beatCycle = 0;
  var rhythm_count = 0;
  var tone = 1;

  int? _drawerCallbackID;

  void _updatePref() async {
    final tempo = await Db.getPref('tempo');
    final beat1 = await Db.getPref('beat1');
    final beat2 = await Db.getPref('beat2');
    final rhythm = await Db.getPref('rhythm');
    final tone = await Db.getPref('tone');

    print(tempo);
    print(beat1);
    print(beat2);

    setState(() {
      this.tempo = tempo;
      this.beat1 = beat1;
      this.beat2 = 1;
      this.rhythm = rhythm;
      this.tone = tone;
    });

    beat_count = 0;
    rhythm_count = 0;
    beatCycle = 0;
  }

  @override
  void initState() {
    super.initState();
    _updatePref();

    _drawerCallbackID = SelectDrawer.addCallback(() {
      _updatePref();
    });

  }

  @override
  void dispose() {
    if (_drawerCallbackID != null)
      SelectDrawer.removeCallback(_drawerCallbackID!);
    super.dispose();
  }

  Future<bool> _tick() async {
    int factor = 0;
    bool silent = false;

    if (rhythm == 0) {
      factor = 60;
    } else if (rhythm == 1) {
      factor = 30;
    } else if (rhythm == 2) {
      factor = 30;
      if (rhythm_count == 0) silent = true;

      if (rhythm_count >= 1) rhythm_count = -1;
    } else if (rhythm == 3) {
      factor = 20;
    } else if (rhythm == 4) {
      factor = 20;
      if (rhythm_count == 1) silent = true;
      if (rhythm_count >= 2) rhythm_count = -1;
    } else if (rhythm == 5) {
      factor = 15;
    } else if (rhythm == 6) {
      factor = 15;
      if (rhythm_count == 0 || rhythm_count == 2) silent = true;
      if (rhythm_count >= 3) rhythm_count = -1;
    } else if (rhythm == 7) {
      if (rhythm_count == 0 || rhythm_count == 1)
        factor = 45;
      else
        factor = 30;

      if (rhythm_count == 3 || rhythm_count == 6) silent = true;

      if (rhythm_count >= 6) rhythm_count = -1;
    } else if (rhythm == 8) {
      if (rhythm_count == 4 || rhythm_count == 5)
        factor = 45;
      else
        factor = 30;

      if (rhythm_count == 0 || rhythm_count == 3) silent = true;

      if (rhythm_count >= 6) rhythm_count = -1;
    }

    ++rhythm_count;

    int ms = (factor * 1000 / tempo).toInt();

    setState(() {
      ++beat_count;
      if (beat_count > (beat1 + beat2)) {
        beat_count = 1;
        beatCycle++;
      };
    });

    if (!silent) {
      if (beat1 != 0 && (beat_count == 1 || beat_count == beat1 + 1))
        await widget.aCache.play('tone/tone$tone\_a.wav');
      else
        await widget.aCache.play('tone/tone$tone\_b.wav');
    }

    await Future.delayed(Duration(milliseconds: ms));

    return _metronome_playing;
  }

  _metronomeTrigger() {
    setState(() {
      _metronome_playing = !_metronome_playing;
    });

    if (_metronome_playing) {
      beat_count = 0;
      Wakelock.toggle(enable: true);
      Future.doWhile(() => _tick());
    }else{
      Wakelock.toggle(enable: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        appBar: AppBar(

          leadingWidth: 100,
          title: const Text(
              'Metronome'
          ),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              Container(
                margin: EdgeInsets.only(bottom: 40, top: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: const TextStyle(
                          fontFamily: 'Courier New',
                          fontSize: 64,
                          color: Colors.black),
                      children: [
                        if (beat1 > 0)
                          TextSpan(
                            text: beat_count > beat1 ? '$beat1' : '$beat_count',
                            style: TextStyle(
                                shadows: (beat_count == 1 && beat1 > 0)
                                    ? [
                                  Shadow(
                                      color: Colors.red.shade900,
                                      offset: Offset(2, 2),
                                      blurRadius: 5)
                                ]
                                    : null,
                                color: (beat_count == 1 && beat1 > 0)
                                    ? Colors.red
                                    : null),
                          ),
                          TextSpan(children: [
                            const TextSpan(text: ':', style: TextStyle(fontSize: 32)),
                            TextSpan(
                                text: beatCycle.toString(),
                                style: TextStyle(
                                    shadows: (beat_count == beat1 + 1)
                                        ? [
                                      Shadow(
                                          color: Colors.red.shade900,
                                          offset: Offset(2, 2),
                                          blurRadius: 5)
                                    ]
                                        : null,
                                    color: (beat_count == beat1 + 1)
                                        ? Colors.red
                                        : null)),
                          ]),
                      ]),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(0,0),
                        spreadRadius: 4.0,
                        blurRadius: 15,
                        blurStyle: BlurStyle.outer
                    ),
                    ]
                ),
                padding: EdgeInsets.all(20),
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(

                      child: IconButton(
                          splashColor: Colors.blue.shade600,
                          splashRadius: 60,
                          iconSize: 102,
                          color: Colors.blue,
                          onPressed: _metronomeTrigger,
                          icon: Icon(_metronome_playing
                              ? Icons.pause
                              : Icons.play_arrow)),
                    ),
                  ],
                ),
              ),

              SelectDrawer(context),

              Container(
                padding: EdgeInsets.only(bottom: 60),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _metronome_playing = false;
                      beatCycle = 0;
                    });

                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Container(
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Colors.blue),
                        )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
