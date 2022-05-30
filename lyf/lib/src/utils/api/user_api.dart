import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../endpoints/user_endpoints.dart';
import '../enums/request_type.dart';
import '../errors/user/user_errors.dart';
import '../helpers/http_helper.dart';
import '../helpers/uri_helper.dart';
import '../../models/user_model.dart';

class UserApiClient {
  UserApiClient._();

  static Future<LyfUser?> logIn(Map<String, String?> userCreds) async {
    http.Response? response;
    LyfUser? authenticatedUser;
    Map<String, String> reqBody = _buildLogInBody(userCreds);
    try {
      response = await HttpHelper.doUserRequest(
        requestType: RequestType.post,
        requestUri: UriHelper.constructUri(
          pathSegs: UserEndpoints.login,
        ),
        addAuthorization: false,
        requestBody: reqBody,
      );
      if (response != null) {
        var authData = jsonDecode(response.body);
        authenticatedUser = LyfUser(
          reqBody["username"]!,
          reqBody["password"]!,
          authData["token"],
          authData["username"],
          authData["userId"],
        );
        if (authData["isActive"] == "True") {
          authenticatedUser.isActive = true;
        } else {
          authenticatedUser.isActive = false;
        }
        log("Logged in");
      }
      return authenticatedUser;
    } on UserException catch (e, stackTr) {
      rethrow;
    }
  }

  static Future<LyfUser?> signUp(Map<String, String?> newUserCreds) async {
    http.Response? response;
    LyfUser? authenticatedNewUser;
    Map<String, String> reqBody = _buildSignUpBody(newUserCreds);
    try {
      response = await HttpHelper.doUserRequest(
        requestType: RequestType.post,
        requestUri: UriHelper.constructUri(
          pathSegs: UserEndpoints.signUp,
        ),
        addAuthorization: false,
        requestBody: reqBody,
      );
      if (response != null) {
        var authData = jsonDecode(response.body);
        authenticatedNewUser = LyfUser(
          reqBody["username"]!,
          reqBody["password"]!,
          authData["token"],
          authData["username"],
          authData["userId"],
        );
        if (authData["isActive"] == "True") {
          authenticatedNewUser.isActive = true;
        } else {
          authenticatedNewUser.isActive = false;
        }
        log("Signed up");
      }
      return authenticatedNewUser;
    } on UserException catch (e, stackTr) {
      rethrow;
    }
  }

  static Future<int> deactivateAccount(LyfUser user) async {
    http.Response? response;
    try {
      response = await HttpHelper.doUserRequest(
        requestType: RequestType.put,
        requestUri: UriHelper.constructUri(
          pathSegs: UserEndpoints.deactivate(user.userId),
        ),
        addAuthorization: true,
      );
      if (response != null) {
        return response.statusCode;
      } else {
        return -1;
      }
    } on UserException catch (e, stackTr) {
      rethrow;
    }
  }

  static Future<int> deleteAccount(LyfUser user) async {
    http.Response? response;
    try {
      response = await HttpHelper.doUserRequest(
        requestType: RequestType.delete,
        requestUri: UriHelper.constructUri(
          pathSegs: UserEndpoints.delete(user.userId),
        ),
        addAuthorization: true,
      );
      if (response != null) {
        return response.statusCode;
      } else {
        return -1;
      }
    } on UserException catch (e, stackTr) {
      rethrow;
    }
  }

  static Map<String, String> _buildLogInBody(Map<String, String?> userCreds) {
    Map<String, String> reqBody;
    try {
      reqBody = {
        "username": userCreds["email"]!,
        "password": userCreds["password"]!,
      };
    } catch (e) {
      throw UserException(e.toString());
    }
    return reqBody;
  }

  static Map<String, String> _buildSignUpBody(
      Map<String, String?> newUserCreds) {
    Map<String, String> reqBody;
    try {
      reqBody = {
        "email": newUserCreds["email"]!,
        "password": newUserCreds["password"]!,
        "username": newUserCreds["username"]!,
      };
    } catch (e) {
      throw UserException(e.toString());
    }
    return reqBody;
  }
}
