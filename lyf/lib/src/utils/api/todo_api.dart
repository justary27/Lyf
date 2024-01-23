import 'dart:convert';
import 'package:http/http.dart' as http;
import '../enums/query_type.dart';
import '../errors/todo/todo_errors.dart';
import '../../global/variables.dart';
import '../endpoints/todo_endpoints.dart';
import '../helpers/uri_helper.dart';
import '../enums/request_type.dart';
import '../helpers/http_helper.dart';
import '../../models/todo_model.dart';

class TodoApiClient {
  TodoApiClient._();

  /// Helper method to create a [Todo] in the database.
  static Future<int> createTodo({
    required Todo todo,
  }) async {
    http.Response? response;
    try {
      response = await HttpHelper.doTodoRequest(
        requestType: RequestType.post,
        requestUri: UriHelper.constructUri(
          // queryType: QueryType.test,
          pathSegs: TodoEndpoints.createTodo(userId: currentUser.userID),
        ),
        requestBody: todo.toData(),
      );
      if (response != null) {
        return response.statusCode;
      } else {
        return -1;
      }
    } on TodoException catch (e, stackTr) {
      rethrow;
    }
  }

  static Future<Todo?> getTodo({
    required Todo todo,
  }) async {
    http.Response? response;
    Todo? responseTodo;
    try {
      response = await HttpHelper.doTodoRequest(
        requestType: RequestType.get,
        requestUri: UriHelper.constructUri(
            pathSegs: TodoEndpoints.getTodo(
          userId: currentUser.userID,
          todoId: todo.id,
        )),
      );
      if (response != null) {
        var decodeResponse = jsonDecode(response.body);
        responseTodo = Todo.fromJson(decodeResponse);
      }
      return responseTodo;
    } on TodoException catch (e, stackTr) {
      return null;
    }
  }

  /// Helper method to retrieve the entire Todo list of a [LyfUser].
  static Future<List<Todo>?> getTodoList() async {
    http.Response? response;
    List<Todo>? todoList;
    try {
      response = await HttpHelper.doTodoRequest(
        requestType: RequestType.get,
        requestUri: UriHelper.constructUri(
          // queryType: QueryType.test,
          pathSegs: TodoEndpoints.getAllTodos(
            userId: currentUser.userID,
          ),
        ),
      );
      if (response != null) {
        todoList = [];
        json.decode(response.body).forEach(
          (element) {
            Todo entry = Todo.fromJson(element);
            print(entry.toData());
            todoList!.add(entry);
          },
        );
      }
      return todoList;
    } on TodoException {
      rethrow;
    }
  }

  static updateTodo({
    required Todo todo,
  }) async {
    http.Response? response;
    try {
      response = await HttpHelper.doTodoRequest(
        requestType: RequestType.put,
        requestUri: UriHelper.constructUri(
          // queryType: QueryType.test,
          pathSegs: TodoEndpoints.updateTodo(
            userId: currentUser.userId,
            todoId: todo.id!,
          ),
        ),
        requestBody: todo.toData(),
      );
      if (response != null) {
        return response.statusCode;
      } else {
        return -1;
      }
    } on TodoException catch (e, stackTr) {
      rethrow;
    }
  }

  /// Helper method to delete a [Todo] in the database.
  static Future<int> deleteTodo({
    required Todo todo,
  }) async {
    http.Response? response;
    try {
      response = await HttpHelper.doTodoRequest(
        requestType: RequestType.delete,
        requestUri: UriHelper.constructUri(
          // queryType: QueryType.test,
          pathSegs: TodoEndpoints.deleteTodo(
            userId: currentUser.userId,
            todoId: todo.id!,
          ),
        ),
      );
      if (response != null) {
        return response.statusCode;
      } else {
        return -1;
      }
    } on TodoException catch (e, stackTr) {
      rethrow;
    }
  }
}
