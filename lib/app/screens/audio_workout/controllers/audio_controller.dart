
import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../models/enums/recorder_state.dart';

class AudioController extends GetxController {
  late final FlutterSoundRecorder _myRecorder = FlutterSoundRecorder();
  late final FlutterSoundPlayer _myPlayer = FlutterSoundPlayer();
  final List<double>? decibels = [];
  String? url;
  bool playing = false;
  String permissionStatus = '';
  RecorderState recorderState = RecorderState.notStarted;
  bool _isRecorderOpen = false;
  StreamSubscription? subs;
  static const String audioFileName = 'pickitaudio';

  initRecordingEvent() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        permissionStatus = 'Microphone permission not granted';
        update();
        return;
      }
      status = await Permission.storage.request();
      if (status != PermissionStatus.granted) {
        permissionStatus = 'Storage permission not granted';
        update();
        return;
      }
    }
    if (!_isRecorderOpen) {
      await _myRecorder.openRecorder();
      _isRecorderOpen = true;
    }
    recorderState = RecorderState.notStarted;
    update();
  }

  startRecordingEvent() async {
    recorderState = RecorderState.notStarted;
    update();
    try {
      decibels?.clear();
      await _myRecorder.startRecorder(toFile: audioFileName);
      await _myRecorder.setSubscriptionDuration(const Duration(seconds: 1));
      subs = _myRecorder.onProgress?.listen((event) {
        if (event.decibels != null) {
          decibels?.add(event.decibels!);
        }
      });
      recorderState = RecorderState.isRecording;
      update();
    } catch(e){
      permissionStatus = e.toString();
    }
  }

  stopRecordingEvent() async {
    await subs?.cancel();
    await _myPlayer.stopPlayer();
    url = await _myRecorder.stopRecorder();
    if (kDebugMode) {
      print('url = $url');
    }
   recorderState = RecorderState.isStopped;
    log('this is the stop: $decibels');
    update();
  }

  restartRecordingEvent() async {
    url = await _myRecorder.stopRecorder();
    if(url!=null) {
      await _myRecorder.deleteRecord(fileName: url!);
      url = null;
    }
    await _myRecorder.startRecorder(toFile: audioFileName);
    recorderState = RecorderState.isRestarted;
    update();
  }

  playRecordingEvent() async {
    await _myPlayer.openPlayer();
    if(url!=null) {
      var duration = await _myPlayer.startPlayer(fromURI: url);
      playing = true;
      update();
      recorderState = RecorderState.isPlaying;
      Future.delayed(duration!, (){
        _myPlayer.stopPlayer();
        recorderState = RecorderState.isStopped;
        _myPlayer.closePlayer();
        playing = false;
        update();
      });
    }
  }
}