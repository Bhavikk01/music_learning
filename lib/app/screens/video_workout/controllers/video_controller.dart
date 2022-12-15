import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../models/enums/recorder_state.dart';

class VideoController extends GetxController {
  RecorderState recorderState = RecorderState.notInitialised;
  late CameraController controller;
  String permissionStatus = '';
  XFile? file;

  initRecordingEvent(CameraController controller) async {
    this.controller = controller;

    var result = await Permission.camera.request();
    if(result.isGranted) {
      await this.controller.initialize();
      await this.controller.startImageStream((image) => image);
      recorderState = RecorderState.notStarted;
      update();
    }else{
      permissionStatus = 'Camera permission required';
      update();
    }
  }

  startRecordingEvent() async {
    log('hello');
    await controller.stopImageStream();
    await controller.startVideoRecording();
    recorderState = RecorderState.isRecording;
    log('hello2');
    update();
  }

  stopRecordingEvent() async {
    file = await controller.stopVideoRecording();
    recorderState = RecorderState.isStopped;
    update();
  }

  restartRecordingEvent() async {
    await controller.stopVideoRecording();
    await controller.startVideoRecording();
    recorderState = RecorderState.isRestarted;
    update();
  }

  playRecordingEvent() async {}
}