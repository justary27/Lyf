import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/todo_model.dart';
import '../../utils/api/todo_api.dart';

final todoNotifier =
    StateNotifierProvider<TodoNotifier, AsyncValue<Todo?>>((ref) {
  return TodoNotifier(ref.read);
});

class TodoNotifier extends StateNotifier<AsyncValue<Todo?>> {
  final Reader read;
  AsyncValue<Todo?>? todo;

  TodoNotifier(
    this.read, [
    AsyncValue<Todo?>? todo,
  ]) : super(todo ?? const AsyncValue.loading()) {
    _retrieveTodo();
  }

  Future<void> _retrieveTodo() async {}

  Future<int> addTodo(Todo todo) async {
    int response = await TodoApiClient.createTodo(
      todo: todo,
    );
    return response;
  }

  Future<int> editTodo(Todo todo) async {
    int response = await TodoApiClient.updateTodo(
      todo: todo,
    );
    return response;
  }

  void _cacheState() {
    todo = state;
  }
}
