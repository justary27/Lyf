import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/state/errors/error_state.dart';
import 'package:lyf/src/state/snackbar/snack_state.dart';
import 'package:lyf/src/utils/enums/snack_type.dart';
import 'package:lyf/src/utils/handlers/file_handler.dart';
import '../../utils/errors/diary/diary_errors.dart';
import '../../utils/api/diary_api.dart';
import '../../models/diary_model.dart';

final diaryNotifier =
    StateNotifierProvider<DiaryNotifier, AsyncValue<List<DiaryEntry>?>>((ref) {
  return DiaryNotifier(ref.read);
});

class DiaryNotifier extends StateNotifier<AsyncValue<List<DiaryEntry>?>> {
  final Reader read;
  AsyncValue<List<DiaryEntry>?>? previousState;

  DiaryNotifier(this.read, [AsyncValue<List<DiaryEntry>?>? entryList])
      : super(entryList ?? const AsyncValue.loading()) {
    _retrieveDiary();
  }

  Future<void> addEntry(DiaryEntry entry) async {
    _cacheState();
    state = state.whenData((diary) => [...diary!, entry]);
    try {
      await DiaryApiClient.createEntry(
        entry: entry,
      );
      await _retrieveDiary();
    } on DiaryException catch (e) {
      handleException(e);
    }
  }

  Future<void> _retrieveDiary() async {
    try {
      List<DiaryEntry>? diary = await DiaryApiClient.getDiary();
      state = AsyncValue.data(diary);
    } on DiaryException catch (e) {
      handleException(e);
    }
  }

  Future<void> refresh() async {
    try {
      List<DiaryEntry>? diary = await DiaryApiClient.getDiary();
      state = AsyncValue.data(diary);
    } catch (e) {
      handleException(e);
      // state = AsyncValue.error(e);
    }
  }

  Future<void> retrieveEntryPdf(DiaryEntry entry) async {
    try {
      await FileHandler.saveEntryPdf(
        entry,
        await DiaryApiClient.getEntryPdf(entry: entry),
      );
    } on DiaryException catch (e) {
      handleException(e);
    }
  }

  Future<void> editEntry(DiaryEntry updatedEntry) async {
    _cacheState();
    state = state.whenData((diary) {
      return [
        for (DiaryEntry entry in diary!)
          if (entry.id == updatedEntry.entryId) entry = updatedEntry else entry
      ];
    });

    try {
      await DiaryApiClient.updateEntry(
        entry: updatedEntry,
      );
      read(snackNotifier.notifier).sendSignal(SnackType.entryUpdated);
    } on DiaryException catch (e) {
      handleException(e);
    }
  }

  Future<void> removeEntry(DiaryEntry entry) async {
    _cacheState();
    state = state.whenData(
      (diary) => diary!.where((element) => element != entry).toList(),
    );
    try {
      await DiaryApiClient.deleteEntry(
        entry: entry,
      );
    } on DiaryException catch (e) {
      handleException(e);
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

  void handleException(Object e) {
    if (state == const AsyncValue<List<DiaryEntry>?>.loading() &&
        e.runtimeType == DiaryException) {
      state = AsyncValue.error(e);
    } else {
      _resetState();
    }
    read(errorNotifier.notifier).addError(e);
  }
}
