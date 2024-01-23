import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/todo_model.dart';

final todoCreateNotifier =
    StateNotifierProvider<TodoCreateNotifier, AsyncValue<Todo?>>((ref) {
  return TodoCreateNotifier(ref);
});

class TodoCreateNotifier extends StateNotifier<AsyncValue<Todo?>> {
  final Ref ref;
  AsyncValue<Todo?>? todo;

  TodoCreateNotifier(
    this.ref, [
    AsyncValue<Todo?>? todo,
  ]) : super(todo ?? const AsyncValue.loading()) {
    // _retrieveTodo();
  }
}
