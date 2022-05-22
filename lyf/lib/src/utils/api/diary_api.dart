import 'package:http/http.dart' as http;
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/utils/endpoints/diary_endpoints.dart';
import 'package:lyf/src/utils/enums/request_type.dart';
import 'package:lyf/src/utils/errors/diary/diary_errors.dart';
import 'package:lyf/src/utils/helpers/http_helper.dart';
import 'package:lyf/src/utils/helpers/uri_helper.dart';

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

  // static Future<DiaryEntry?> getEntry({
  //   required DiaryEntry entry,
  // }) async {
  //   late http.Response response;
  //   try {
  //     response = await HttpHelper.doDiaryRequest(
  //       requestType: RequestType.put,
  //       requestUri: UriHelper.constructUri(
  //         pathSegs: DiaryEndpoints.getEntry(
  //           userId: currentUser.userId,
  //           entryId: entry.entryId!,
  //         ),
  //       ),
  //     );
  //     return DiaryEntry.fromJson(response);
  //   } catch (e) {
  //     throw DiaryException(response.body.toString());
  //   }
  // }

  // static Future<List<DiaryEntry>?> getDiary({
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
