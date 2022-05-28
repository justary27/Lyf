import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/todo_model.dart';

final todoCreateNotifier =
    StateNotifierProvider<TodoCreateNotifier, AsyncValue<Todo?>>((ref) {
  return TodoCreateNotifier(ref.read);
});

class TodoCreateNotifier extends StateNotifier<AsyncValue<Todo?>> {
  final Reader read;
  AsyncValue<Todo?>? todo;

  TodoCreateNotifier(
    this.read, [
    AsyncValue<Todo?>? todo,
  ]) : super(todo ?? const AsyncValue.loading()) {
    // _retrieveTodo();
  }
}
