import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:lyf/src/utils/enums/error_type.dart';

import '../../global/variables.dart';
import '../enums/request_type.dart';
import '../errors/diary/diary_errors.dart';
import '../errors/todo/todo_errors.dart';
import '../errors/user/user_errors.dart';

class HttpHelper {
  HttpHelper._();

  static Future<http.Response?> doUserRequest({
    required RequestType requestType,
    required Uri requestUri,
    required bool addAuthorization,
    Map<String, String>? requestBody,
  }) async {
    http.Response? response;
    try {
      if (requestType == RequestType.get) {
        response = await http.get(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: addAuthorization,
          ),
        );
      } else if (requestType == RequestType.post) {
        response = await http.post(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: addAuthorization,
          ),
          body: requestBody,
        );
      } else if (requestType == RequestType.put) {
        response = await http.put(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: addAuthorization,
          ),
          body: requestBody,
        );
      } else {
        response = await http.delete(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: addAuthorization,
          ),
          body: requestBody,
        );
      }
      if (response.statusCode == 200) {
        return response;
      } else {
        throw UserException(response.body.toString());
      }
    } catch (e) {
      if (e.runtimeType == UserException) {
        rethrow;
      } else {
        throw Exception(e.toString());
      }
    }
  }

  static Future<http.Response?> doTodoRequest({
    required RequestType requestType,
    required Uri requestUri,
    Map<String, String>? requestBody,
  }) async {
    http.Response? response;
    try {
      if (requestType == RequestType.get) {
        response = await http.get(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: true,
          ),
        );
      } else if (requestType == RequestType.post) {
        response = await http.post(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: true,
          ),
          body: requestBody,
        );
      } else if (requestType == RequestType.put) {
        response = await http.put(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: true,
          ),
          body: requestBody,
        );
      } else {
        response = await http.delete(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: true,
          ),
          body: requestBody,
        );
      }
      if (response.statusCode == 200) {
        return response;
      } else {
        throw TodoException(response.body.toString());
      }
    } catch (e) {
      if (e.runtimeType == SocketException) {
        throw TodoException(
          e.toString(),
          errorType: ErrorType.networkError,
        );
      } else {
        throw TodoException(e.toString());
      }
    }
  }

  static Future<http.Response?> doDiaryRequest({
    required RequestType requestType,
    required Uri requestUri,
    Map<String, String>? requestBody,
  }) async {
    http.Response? response;
    try {
      if (requestType == RequestType.get) {
        response = await http.get(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: true,
          ),
        );
      } else if (requestType == RequestType.post) {
        response = await http.post(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: true,
          ),
          body: requestBody,
        );
      } else if (requestType == RequestType.put) {
        response = await http.put(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: true,
          ),
          body: requestBody,
        );
      } else {
        response = await http.delete(
          requestUri,
          headers: _buildHeaders(
            setAuthorization: true,
          ),
          body: requestBody,
        );
      }
      if (response.statusCode == 200) {
        return response;
      } else {
        throw DiaryException(response.body.toString());
      }
    } catch (e) {
      if (e.runtimeType == SocketException) {
        throw DiaryException(
          e.toString(),
          errorType: ErrorType.networkError,
        );
      } else {
        throw DiaryException(e.toString());
      }
    }
  }

  static Map<String, String> _buildHeaders({
    required bool setAuthorization,
  }) {
    Map<String, String> headers = {};
    if (setAuthorization) {
      headers.addAll(currentUser.authHeader());
    }
    return headers;
  }
}
