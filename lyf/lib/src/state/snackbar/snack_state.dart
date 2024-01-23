import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../global/variables.dart';
import '../../shared/snackbars/create_snack.dart';
import '../../shared/snackbars/networkerror_snack.dart';
import '../../shared/snackbars/permissonerror_snack.dart';
import '../../shared/snackbars/update_snack.dart';
import '../../utils/enums/snack_type.dart';

final snackNotifier =
    StateNotifierProvider<SnackNotifier, Stream<SnackType>>((ref) {
  return SnackNotifier(ref);
});

class SnackNotifier extends StateNotifier<Stream<SnackType>> {
  final Ref ref;
  final StreamController<SnackType> stateStreamController = StreamController();

  Stream<SnackType>? previousState;

  SnackNotifier(this.ref, [Stream<SnackType>? error])
      : super(error ?? const Stream.empty()) {
    state = stateStreamController.stream;
  }

  void sendSnack(SnackType signal, {Object? arguments}) {
    switch (signal) {
      case SnackType.networkError:
        snackKey.currentState!.showSnackBar(networkErrorSnack);
        break;
      case SnackType.permissionError:
        snackKey.currentState!.showSnackBar(permissionErrorSnack);
        break;
      case SnackType.todoCreated:
        snackKey.currentState!.showSnackBar(todoSuccessSnack);
        break;
      case SnackType.todoUpdated:
        snackKey.currentState!.showSnackBar(todoUpdateSnack);
        break;
      case SnackType.entryCreated:
        snackKey.currentState!.showSnackBar(diarySuccessSnack);
        break;
      case SnackType.entryUpdated:
        snackKey.currentState!.showSnackBar(diaryUpdateSnack);
        break;
      default:
        snackKey.currentState!.showSnackBar(networkErrorSnack);
        break;
    }
  }

  void sendSignal(SnackType signal, {Object? arguments}) {
    stateStreamController.add(signal);
    sendSnack(signal, arguments: arguments);
  }
}
