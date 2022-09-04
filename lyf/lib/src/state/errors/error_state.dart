import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/errors/diary/diary_errors.dart';
import '../../utils/errors/todo/todo_errors.dart';
import '../../utils/errors/user/user_errors.dart';
import '../../utils/enums/error_type.dart';

final errorNotifier =
    StateNotifierProvider<ErrorNotifier, Stream<dynamic>>((ref) {
  return ErrorNotifier(ref.read);
});

class ErrorNotifier extends StateNotifier<Stream<dynamic>> {
  final Reader read;
  final StreamController stateStreamController = StreamController();

  Stream<dynamic>? previousState;

  ErrorNotifier(this.read, [Stream<dynamic>? error])
      : super(error ?? const Stream.empty()) {
    state = stateStreamController.stream;
  }

  void takeAction(dynamic error) {
    log(error.toString());

    switch (error.runtimeType) {
      case UserException:
        handleUserError();
        break;
      case TodoException:
        handleTodoError(error);
        break;
      case DiaryException:
        handleDiaryError(error);
        break;
      default:
        break;
    }
  }

  void handleUserError() {}

  void handleTodoError(error) {
    if (error.errorType != null && error.errorType == ErrorType.networkError) {
    } else {}
  }

  void handleDiaryError(error) {
    if (error.errorType != null && error.errorType == ErrorType.networkError) {
    } else {}
  }

  void addError(dynamic error) {
    stateStreamController.add(error);
    takeAction(error);
  }
}
