import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/state/snackbar/snack_state.dart';

import '../../models/todo_model.dart';
import '../../utils/api/todo_api.dart';
import '../../utils/enums/snack_type.dart';
import '../../utils/errors/todo/todo_errors.dart';
import '../errors/error_state.dart';
// import 'todo_view_state.dart';

final todoListNotifier =
    StateNotifierProvider<TodoListNotifier, AsyncValue<List<Todo>?>>((ref) {
  return TodoListNotifier(ref);
});

class TodoListNotifier extends StateNotifier<AsyncValue<List<Todo>?>> {
  final Ref ref;
  AsyncValue<List<Todo>?>? previousState;

  TodoListNotifier(this.ref, [AsyncValue<List<Todo>?>? todoList])
      : super(todoList ?? const AsyncValue.loading()) {
    retrieveTodoList();
  }

  Future<void> addTodo(Todo todo) async {
    _cacheState();
    state = state.whenData((todoList) => [...todoList!, todo]);

    try {
      await TodoApiClient.createTodo(
        todo: todo,
      );
      await retrieveTodoList();
    } on TodoException catch (e) {
      handleException(e);
    }
  }

  Future<void> retrieveTodoList() async {
    try {
      List<Todo>? todoList = await TodoApiClient.getTodoList();
      state = AsyncValue.data(todoList);
    } on TodoException catch (e) {
      handleException(e);
    }
  }

  Future<void> refresh() async {
    try {
      List<Todo>? todoList = await TodoApiClient.getTodoList();
      state = AsyncValue.data(todoList);
    } catch (e) {
      handleException(e);
    }
  }

  Future<void> editTodo(Todo updatedTodo) async {
    _cacheState();
    state = state.whenData((todoList) {
      return [
        for (Todo todo in todoList!)
          if (todo.id == updatedTodo.id) todo = updatedTodo else todo
      ];
    });

    try {
      await TodoApiClient.updateTodo(todo: updatedTodo);
      ref.read(snackNotifier.notifier).sendSignal(SnackType.todoUpdated);
    } on TodoException catch (e) {
      handleException(e);
    }
  }

  Future<void> removeTodo(Todo todo) async {
    _cacheState();
    state = state.whenData(
      (todoList) => todoList!.where((element) => element != todo).toList(),
    );
    try {
      await TodoApiClient.deleteTodo(todo: todo);
    } on TodoException catch (e) {
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
    if (state == const AsyncValue<List<Todo>?>.loading() &&
        e.runtimeType == TodoException) {
      state = AsyncValue.error(e, StackTrace.current);
    } else {
      _resetState();
    }
    ref.read(errorNotifier.notifier).addError(e);
  }
}
