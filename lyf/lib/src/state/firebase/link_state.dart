import 'dart:async';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final deepLinkNotifier =
    StateNotifierProvider<DeepLinkNotifier, Stream<dynamic>>((ref) {
  return DeepLinkNotifier(ref);
});

class DeepLinkNotifier extends StateNotifier<Stream<dynamic>> {
  final Ref ref;
  final StreamController stateStreamController = StreamController();

  Stream<dynamic>? previousState;

  DeepLinkNotifier(this.ref, [Stream<dynamic>? pathStream])
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
