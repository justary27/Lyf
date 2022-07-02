import 'dart:developer';
import 'package:lyf/src/global/variables.dart';
import 'package:http/http.dart' as http;
import 'package:lyf/src/services/http.dart';
import 'package:json_annotation/json_annotation.dart';
import '../interface/json_object.dart';

part 'todo_model.g.dart';

/// ## Todo
/// Defining class of a todo in the todo list of a [LyfUser].
@JsonSerializable()
class Todo extends JsonObject {
  /// Unique Id of a [Todo]
  @JsonKey(name: "_id")
  final String? id;

  /// Title of a [Todo]
  @JsonKey(name: "_title")
  final String title;

  /// Description of a [Todo]
  @JsonKey(name: "_description")
  final String description;

  /// Time when a [Todo] was created.
  @JsonKey(name: "_createdAt")
  final DateTime createdAt;

  /// Is a reminder set for the [Todo] in Google Calendar?
  @JsonKey(name: "_isReminderSet")
  final bool isReminderSet;

  /// Time when reminder is set in Google Calander, null if !_isReminderSet
  @JsonKey(name: "_reminderAt")
  final DateTime? reminderAt;

  // Constructor

  Todo(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.isReminderSet,
    this.reminderAt,
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

  // bool get isReminderSet {
  //   return isReminderSet;
  // }

  // DateTime? get reminderAt {
  //   return reminderAt;
  // }

  // Json Methods

  /// Standard fromJson() method.
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  /// Standard toJson() method.
  @override
  Map<String, dynamic> toJson() => _$TodoToJson(this);

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
        // body: Todo.toJson(todo),
        headers: currentUser.authHeader(),
      );
      return response.statusCode;
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }
}
