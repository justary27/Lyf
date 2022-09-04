import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../utils/handlers/file_handler.dart';
import '../../shared/viewers/audio_viewer.dart';
import '../../shared/viewers/image_viewer.dart';

class WidgetLauncher {
  WidgetLauncher._();

  static Future<Widget?> launchAudioWidget({
    required Size size,
    required void Function(bool flag) notifyflagChange,
    required void Function(PlatformFile? file) fileServer,
    List<Widget>? stateWidgetList,
    String? audioUrl,
  }) async {
    Widget? audioViewer;
    // TODO: Handle audioUrl == "" case on audioFile deletion;
    if (audioUrl == null) {
      PlatformFile? audioFile = await FileHandler.pickAudioFile();
      notifyflagChange(true);
      fileServer(audioFile);
      audioViewer = AudioViewer(
        size: size,
        audioFile: audioFile!,
        notifyflagChange: notifyflagChange,
        fileHandler: fileServer,
        stateWidgetList: stateWidgetList,
      );
    } else {
      if (audioUrl != "") {
        audioViewer = AudioViewer(
          size: size,
          notifyflagChange: notifyflagChange,
          fileHandler: fileServer,
          stateWidgetList: stateWidgetList,
          audioUrl: audioUrl,
        );
      } else {
        audioViewer = null;
      }
    }
    return audioViewer;
  }

  static Future<Widget?> launchImageWidget({
    required Size size,
    required void Function(bool flag) notifyflagChange,
    required void Function(List<PlatformFile?>? files) fileServer,
    required void Function() onValueDelete,
    List<String>? imageUrls,
    List<Widget>? stateWidgetList,
  }) async {
    Widget? imageViewer;
    if (imageUrls == null) {
      List<PlatformFile?>? imageFiles = await FileHandler.pickImages();
      notifyflagChange(true);
      fileServer(imageFiles);
      imageViewer = ImageViewer(
        size: size,
        imageFiles: imageFiles,
        notifyflagChange: notifyflagChange,
        fileHandler: fileServer,
        stateWidgetList: stateWidgetList,
        onValueDelete: onValueDelete,
      );
    } else {
      imageViewer = ImageViewer(
        size: size,
        imageUrls: imageUrls,
        notifyflagChange: notifyflagChange,
        fileHandler: fileServer,
        stateWidgetList: stateWidgetList,
        onValueDelete: onValueDelete,
      );
    }
    return imageViewer;
  }
}
