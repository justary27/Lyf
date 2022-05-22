import 'package:http/http.dart' as http;
import 'package:lyf/src/utils/enums/request_type.dart';

import '../errors/diary/diary_errors.dart';
import '../errors/todo/todo_errors.dart';
import '../errors/user/user_errors.dart';

class HttpHelper {
  HttpHelper._();

  static Future<http.Response> doUserRequest({
    required RequestType requestType,
    required Uri requestUri,
    Map<String, String>? requestBody,
  }) async {
    late http.Response response;
    try {
      if (requestType == RequestType.get) {
        response = await http.get(
          requestUri,
          headers: _buildHeaders(),
        );
      } else if (requestType == RequestType.post) {
        response = await http.post(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      } else if (requestType == RequestType.put) {
        response = await http.put(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      } else {
        response = await http.delete(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      }
      if (response.statusCode == 200) {
        return response;
      } else {
        throw UserException(response.body.toString());
      }
    } catch (e) {
      throw UserException(e.toString());
    }
  }

  static Future<http.Response> doTodoRequest({
    required RequestType requestType,
    required Uri requestUri,
    Map<String, String>? requestBody,
  }) async {
    late http.Response response;
    try {
      if (requestType == RequestType.get) {
        response = await http.get(
          requestUri,
          headers: _buildHeaders(),
        );
      } else if (requestType == RequestType.post) {
        response = await http.post(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      } else if (requestType == RequestType.put) {
        response = await http.put(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      } else {
        response = await http.delete(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      }
      if (response.statusCode == 200) {
        return response;
      } else {
        throw TodoException(response.body.toString());
      }
    } catch (e) {
      throw TodoException(e.toString());
    }
  }

  static Future<http.Response> doDiaryRequest({
    required RequestType requestType,
    required Uri requestUri,
    Map<String, String>? requestBody,
  }) async {
    late http.Response response;
    try {
      if (requestType == RequestType.get) {
        response = await http.get(
          requestUri,
          headers: _buildHeaders(),
        );
      } else if (requestType == RequestType.post) {
        response = await http.post(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      } else if (requestType == RequestType.put) {
        response = await http.put(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      } else {
        response = await http.delete(
          requestUri,
          headers: _buildHeaders(),
          body: requestBody,
        );
      }
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DiaryException(response.body.toString());
      }
    } catch (e) {
      throw DiaryException(e.toString());
    }
  }

  static Map<String, String> _buildHeaders() {
    return {};
  }
}
