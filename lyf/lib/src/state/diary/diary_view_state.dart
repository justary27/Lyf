import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/utils/launchers/widget_launchers.dart';

final diaryViewNotifier = StateNotifierProvider.family<ViewDiaryNotifier,
    AsyncValue<List<Widget>?>, List<Widget>?>((ref, widgetList) {
  return ViewDiaryNotifier(
    ref.read,
    AsyncValue.data(widgetList),
  );
});

class ViewDiaryNotifier extends StateNotifier<AsyncValue<List<Widget>?>> {
  final Reader read;
  AsyncValue<List<Widget>?>? previousState;

  ViewDiaryNotifier(this.read, [AsyncValue<List<Widget>?>? widgetList])
      : super(widgetList ?? const AsyncValue.loading());

  Future<void> addAudioAttachment({
    required Size size,
    required void Function(bool flag) notifyflagChange,
    required void Function(PlatformFile? file) fileServer,
    List<Widget>? stateWidgetList,
    String? audioUrl,
  }) async {
    try {
      Widget? audioWidget = await WidgetLauncher.launchAudioWidget(
        size: size,
        notifyflagChange: notifyflagChange,
        fileServer: fileServer,
        stateWidgetList: stateWidgetList,
        audioUrl: audioUrl,
      );
      state = state.whenData((widgetList) => [...widgetList!, audioWidget!]);
    } catch (e) {
      _handleException(e);
    }
  }

  void deleteAudioAttachment() {
    _cacheState();
    try {
      state = state.whenData((widgetList) => widgetList!
          .where((widget) => widget.key != const Key("audioAttachment"))
          .toList());
    } catch (e) {
      log(e.toString());
      _handleException(e);
    }
  }

  addImageAttachment({
    required Size size,
    required void Function(bool flag) notifyflagChange,
    required void Function(List<PlatformFile?>? file) fileServer,
    List<Widget>? stateWidgetList,
    List<String>? imageUrls,
  }) async {
    try {
      Widget? imageWidget = await WidgetLauncher.launchImageWidget(
        size: size,
        notifyflagChange: notifyflagChange,
        fileServer: fileServer,
        stateWidgetList: stateWidgetList,
        imageUrls: imageUrls,
      );
      state = state.whenData((widgetList) => [...widgetList!, imageWidget!]);
    } catch (e) {
      _handleException(e);
    }
  }

  deleteImageAttachments() {
    _cacheState();
    try {
      state = state.whenData((widgetList) => widgetList!
          .where((widget) => widget.key != const Key("imageAttachment"))
          .toList());
    } catch (e) {
      log(e.toString());
      _handleException(e);
    }
  }

  void _cacheState() {
    previousState = state;
  }

  void _resetState() {
    if (previousState != null) {
      state = previousState!;
      previousState = null;
    }
  }

  void _handleException(e) {
    _resetState();
    // read(todoExceptionProvider).state = e;
  }

  void clearState() {
    state = AsyncValue.data(null);
  }
}
