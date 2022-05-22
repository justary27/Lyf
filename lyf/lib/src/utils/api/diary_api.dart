import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../global/globals.dart';
import '../../models/diary_model.dart';
import '../endpoints/diary_endpoints.dart';
import '../enums/request_type.dart';
import '../errors/diary/diary_errors.dart';
import '../helpers/http_helper.dart';
import '../helpers/uri_helper.dart';

class DiaryApiClient {
  DiaryApiClient._();

  static Future<int> createEntry({
    required DiaryEntry entry,
  }) async {
    late http.Response response;
    try {
      response = await HttpHelper.doDiaryRequest(
        requestType: RequestType.post,
        requestUri: UriHelper.constructUri(
          pathSegs: DiaryEndpoints.createEntry(
            userId: currentUser.userId,
          ),
        ),
        // requestBody: DiaryEntry.toJson(entry);
      );
      return response.statusCode;
    } catch (e) {
      throw DiaryException(response.body.toString());
    }
  }

  static Future<DiaryEntry?> getEntry({
    required DiaryEntry entry,
  }) async {
    late http.Response response;
    try {
      response = await HttpHelper.doDiaryRequest(
        requestType: RequestType.put,
        requestUri: UriHelper.constructUri(
          pathSegs: DiaryEndpoints.getEntry(
            userId: currentUser.userId,
            entryId: entry.entryId!,
          ),
        ),
      );
      var decodeResponse = jsonDecode(response.body);
      return DiaryEntry.fromJson(decodeResponse);
    } catch (e) {
      throw DiaryException(response.body.toString());
    }
  }

  static Future<List<DiaryEntry>?> getDiary() async {
    late http.Response response;
    List<DiaryEntry>? diary;
    try {
      response = await HttpHelper.doDiaryRequest(
        requestType: RequestType.put,
        requestUri: UriHelper.constructUri(
          pathSegs: DiaryEndpoints.getAllEntries(
            userId: currentUser.userId,
          ),
        ),
      );
      diary = [];
      json.decode(response.body).forEach((element) {
        DiaryEntry entry = DiaryEntry.fromJson(element);
        diary!.add(entry);
      });
      return diary;
    } catch (e) {
      throw DiaryException(response.body.toString());
    }
  }

  // static Future<void> getEntryPdf({
  //   required DiaryEntry entry,
  // }) async {
  //   late http.Response response;
  //   try {
  //     response = await HttpHelper.doDiaryRequest(
  //       requestType: RequestType.put,
  //       requestUri: UriHelper.constructUri(
  //         pathSegs: DiaryEndpoints.updateEntry(
  //           userId: currentUser.userId,
  //           entryId: entry.entryId!,
  //         ),
  //       ),
  //       // requestBody: DiaryEntry.toJson(entry);
  //     );
  //     return response.statusCode;
  //   } catch (e) {
  //     throw DiaryException(response.body.toString());
  //   }
  // }

  // static Future<void> getDiaryPdf({
  //   required DiaryEntry entry,
  // }) async {
  //   late http.Response response;
  //   try {
  //     response = await HttpHelper.doDiaryRequest(
  //       requestType: RequestType.put,
  //       requestUri: UriHelper.constructUri(
  //         pathSegs: DiaryEndpoints.updateEntry(
  //           userId: currentUser.userId,
  //           entryId: entry.entryId!,
  //         ),
  //       ),
  //       // requestBody: DiaryEntry.toJson(entry);
  //     );
  //     return response.statusCode;
  //   } catch (e) {
  //     throw DiaryException(response.body.toString());
  //   }
  // }

  static Future<int> updateEntry({
    required DiaryEntry entry,
  }) async {
    late http.Response response;
    try {
      response = await HttpHelper.doDiaryRequest(
        requestType: RequestType.put,
        requestUri: UriHelper.constructUri(
          pathSegs: DiaryEndpoints.updateEntry(
            userId: currentUser.userId,
            entryId: entry.entryId!,
          ),
        ),
        // requestBody: DiaryEntry.toJson(entry);
      );
      return response.statusCode;
    } catch (e) {
      throw DiaryException(response.body.toString());
    }
  }

  static Future<int> deleteEntry({
    required DiaryEntry entry,
  }) async {
    late http.Response response;
    try {
      response = await HttpHelper.doDiaryRequest(
        requestType: RequestType.delete,
        requestUri: UriHelper.constructUri(
          pathSegs: DiaryEndpoints.deleteEntry(
            userId: currentUser.userId,
            entryId: entry.entryId!,
          ),
        ),
        // requestBody: DiaryEntry.toJson(entry);
      );
      return response.statusCode;
    } catch (e) {
      throw DiaryException(response.body.toString());
    }
  }
}
