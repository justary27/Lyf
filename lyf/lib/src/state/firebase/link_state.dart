import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deepLinkNotifier =
    StateNotifierProvider<DeepLinkNotifier, Stream<dynamic>>((ref) {
  return DeepLinkNotifier(ref.read);
});

class DeepLinkNotifier extends StateNotifier<Stream<dynamic>> {
  final Reader read;
  final StreamController stateStreamController = StreamController();

  Stream<dynamic>? previousState;

  DeepLinkNotifier(this.read, [Stream<dynamic>? pathStream])
      : super(pathStream ?? const Stream.empty()) {
    state = stateStreamController.stream;
  }

  void navigate(dynamic error) {
    log(error.toString());
  }

  void addError(String path) {
    stateStreamController.add(path);
    navigate(path);
  }
}
