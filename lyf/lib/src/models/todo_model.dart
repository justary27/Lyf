import 'dart:convert';
import 'dart:developer';
import 'package:lyf/src/global/globals.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';

/// ## Todo
/// Defining class of a todo in the todo list of a [LyfUser].
class Todo {
  /// Unique Id of a [Todo]
  final String? id;

  /// Title of a [Todo]
  final String title;

  /// Description of a [Todo]
  final String description;

  /// Time when a [Todo] was created.
  final DateTime createdAt;

  /// Is a reminder set for the [Todo] in Google Calendar?
  final bool _isReminderSet;

  /// Time when reminder is set in Google Calander, null if !_isReminderSet
  final DateTime? _reminderAt;

  // Constructor

  Todo(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this._isReminderSet,
    this._reminderAt,
  );

  // Class properties

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

  // Json Methods

  /// Standard fromJson() method.
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

  /// Standard toJson() method.
  static Map<String, dynamic> toJson(Todo todo) {
    return {
      '_userId': currentUser.userID,
      '_title': todo.title,
      '_description': todo.description,
      '_created_on': todo.createdAt.toIso8601String(),
    };
  }

  /// Helper method to create a [Todo] in the database.
  static Future<int> createTodo({
    required http.Client createTodoClient,
    required Todo todo,
  }) async {
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
      log(e.toString());
      return -1;
    }
  }

  /// Helper method to update a [Todo] in the database.
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
      log(e.toString());
      return -1;
    }
  }

  /// Helper method to delete a [Todo] in the database.
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
      log(e.toString());
      return -1;
    }
  }

  /// Helper method to retrieve the entire Todo list of a [LyfUser].
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
      log(e.toString());
      retrieveStatusNotifier(false);
      return [null];
    }
  }
}
