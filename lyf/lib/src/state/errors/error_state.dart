import 'dart:async';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/state/snackbar/snack_state.dart';

import '../../utils/enums/error_type.dart';
import '../../utils/enums/snack_type.dart';
import '../../utils/errors/diary/diary_errors.dart';
import '../../utils/errors/services/service_errors.dart';
import '../../utils/errors/todo/todo_errors.dart';
import '../../utils/errors/user/user_errors.dart';

final errorNotifier =
    StateNotifierProvider<ErrorNotifier, Stream<dynamic>>((ref) {
  return ErrorNotifier(ref);
});

class ErrorNotifier extends StateNotifier<Stream<dynamic>> {
  final Ref ref;
  final StreamController stateStreamController = StreamController();

  Stream<dynamic>? previousState;

  ErrorNotifier(this.ref, [Stream<dynamic>? error])
      : super(error ?? const Stream.empty()) {
    state = stateStreamController.stream;
  }

  void takeAction(dynamic error) {
    log(error.toString());

    switch (error.runtimeType) {
      case UserException _:
        handleUserError();
        break;
      case TodoException _:
        handleTodoError(error);
        break;
      case DiaryException _:
        handleDiaryError(error);
        break;
      case ServiceException _:
        handleServiceError(error);
        break;
      default:
        break;
    }
  }

  void handleUserError() {}

  void handleTodoError(error) {
    if (error.errorType != null && error.errorType == ErrorType.networkError) {
      ref.read(snackNotifier.notifier).sendSignal(
            SnackType.networkError,
          );
    } else {}
  }

  void handleDiaryError(error) {
    if (error.errorType != null && error.errorType == ErrorType.networkError) {
      ref.read(snackNotifier.notifier).sendSignal(
            SnackType.networkError,
          );
    } else {}
  }

  void handleServiceError(error) {
    if (error.errorType != null &&
        error.errorType == ErrorType.permissionError) {
      ref.read(snackNotifier.notifier).sendSignal(
            SnackType.permissionError,
          );
    } else {}
  }

  void addError(dynamic error) {
    stateStreamController.add(error);
    takeAction(error);
  }
}
