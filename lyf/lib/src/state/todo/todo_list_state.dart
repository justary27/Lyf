import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/todo_model.dart';
import '../../utils/api/todo_api.dart';
import '../../utils/errors/todo/todo_errors.dart';
import 'todo_view_state.dart';

final todoListNotifier =
    StateNotifierProvider<TodoListNotifier, AsyncValue<List<Todo>?>>((ref) {
  return TodoListNotifier(ref.read);
});

class TodoListNotifier extends StateNotifier<AsyncValue<List<Todo>?>> {
  final Reader read;
  AsyncValue<List<Todo>?>? previousState;

  TodoListNotifier(this.read, [AsyncValue<List<Todo>?>? todoList])
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
      _handleException(e);
    }
  }

  Future<void> retrieveTodoList() async {
    print("hello");
    List<Todo>? todoList = await TodoApiClient.getTodoList();
    // await read(todoRepositoryProvider).retrieveTodoList();
    state = AsyncValue.data(todoList);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      List<Todo>? todoList = await TodoApiClient.getTodoList();
      state = AsyncValue.data(todoList);
    } catch (e) {
      state = AsyncValue.error(e);
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
    } on TodoException catch (e) {
      _handleException(e);
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
      _handleException(e);
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

  void _handleException(TodoException e) {
    _resetState();
    // read(todoExceptionProvider).state = e;
  }
}
