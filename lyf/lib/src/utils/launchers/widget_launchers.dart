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
  }) async {
    Widget? audioViewer;
    PlatformFile? audioFile = await FileHandler.pickAudioFile();
    if (audioFile != null) {
      notifyflagChange(true);
      fileServer(audioFile);
      audioViewer = AudioViewer(
        size: size,
        audioFile: audioFile,
        notifyflagChange: notifyflagChange,
        fileHandler: fileServer,
        stateWidgetList: stateWidgetList,
      );
    }
    return audioViewer;
  }

  static Future<Widget?> launchImageWidget({
    required Size size,
    required void Function(bool flag) notifyflagChange,
    required void Function(List<PlatformFile?>? files) fileServer,
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
      );
    } else {
      imageViewer = ImageViewer(
        size: size,
        imageUrls: imageUrls,
        notifyflagChange: notifyflagChange,
        fileHandler: fileServer,
        stateWidgetList: stateWidgetList,
      );
    }
    return imageViewer;
  }
}
