import 'dart:convert';

import 'package:lyf/src/global/globals.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';

class Todo {
  final String? id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool _isReminderSet;
  final DateTime? _reminderAt;

  Todo(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this._isReminderSet,
    this._reminderAt,
  );

  String? get entryId {
    return id;
  }

  String get todoTitle {
    return title;
  }

  String get todoDescription {
    return description;
  }

  DateTime get todoCreatedAt {
    return createdAt;
  }

  bool get isReminderSet {
    return _isReminderSet;
  }

  DateTime? get reminderAt {
    return _reminderAt;
  }

  ///Creates a [Todo] instance from json.
  ///
  ///[json] Map<String, dynamic> Sent by backend & required to create the new instance,
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
        json['id'],
        json['title'],
        json['description'],
        DateTime.parse(json['createdAt']),
        json['isReminderSet'],
        (json['reminderAt'] != "None")
            ? DateTime.parse(json['reminderAt'])
            : null);
  }

  ///Converts a Todo object to json.
  ///
  ///[deleteTodoClient] http.Client required for contacting with Backend API
  ///[todo] Todo instance to delete

  static Map<String, dynamic> toJson(Todo todo) {
    return {
      '_userId': currentUser.userID,
      '_title': todo.title,
      '_description': todo.description,
      '_created_on': todo.createdAt.toIso8601String(),
    };
  }

  ///Creates a new Todo.
  ///
  ///[createTodoClient] http.Client required for contacting with Backend API
  ///[todo] Todo instance to create
  static Future<int> createTodo({
    required http.Client createTodoClient,
    required Todo todo,
  }) async {
    late int statusCode;
    http.Response? response;
    try {
      response = await createTodoClient.post(
        Uri.parse(
          ApiEndpoints.createTodo(currentUser.userID),
        ),
        body: Todo.toJson(todo),
        headers: currentUser.authHeader(),
      );
      return response.statusCode;
    } catch (e) {
      print(e);
      return -1;
    }
  }

  ///Updates a given Todo.
  ///
  ///[updateTodoClient] http.Client required for contacting with Backend API
  ///[todo] Todo instance to update
  static Future<int> updateTodo({
    required http.Client updateTodoClient,
    required Todo todo,
  }) async {
    http.Response? response;
    try {
      response = await updateTodoClient.put(
        Uri.parse(
          ApiEndpoints.updateTodo(currentUser.userID, todo.entryId!),
        ),
        body: Todo.toJson(todo),
        headers: currentUser.authHeader(),
      );
      return response.statusCode;
    } catch (e) {
      print(e);
      return -1;
    }
  }

  ///Deletes a given Todo.
  ///
  ///[deleteTodoClient] http.Client required for contacting with Backend API
  ///[todo] Todo instance to delete
  static Future<int> deleteTodo({
    required http.Client deleteTodoClient,
    required Todo todo,
  }) async {
    http.Response? response;
    try {
      response = await deleteTodoClient.delete(
        Uri.parse(
          ApiEndpoints.deleteTodo(currentUser.userID, todo.entryId!),
        ),
        headers: currentUser.authHeader(),
      );
      return response.statusCode;
    } catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<List<Todo?>?> getTodos({
    required http.Client getTodoClient,
    required void Function(bool flag) retrieveStatusNotifier,
  }) async {
    http.Response? response;
    List<Todo>? todo;
    try {
      response = await getTodoClient.get(
        Uri.parse(
          ApiEndpoints.getAllEntries(currentUser.userID),
        ),
        headers: currentUser.authHeader(),
      );
      if (response.statusCode == 200) {
        todo = [];
        json.decode(response.body).forEach((element) {
          Todo entry = Todo.fromJson(element);
          todo!.add(entry);
        });
        retrieveStatusNotifier(true);
        return todo;
      } else {
        retrieveStatusNotifier(false);
        return [null];
      }
    } catch (e) {
      print(e);
      retrieveStatusNotifier(false);
      return [null];
    }
  }
}
