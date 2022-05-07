import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/permissions/permission_handler.dart';
import 'package:lyf/src/services/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:developer';

/// ## Diary
/// Defining class of an entry in diary of a [LyfUser].
class DiaryEntry {
  /// Unique Id of a [DiaryEntry]
  final String? id;

  /// Title of a [DiaryEntry]
  final String title;

  /// Description of a [DiaryEntry]
  final String description;

  /// Time when the [DiaryEntry] was created
  final DateTime createdAt;

  /// Url of an audioFile attached with the [DiaryEntry]
  String? audioLink;

  /// A list of urls attached with the [DiaryEntry]
  List<String>? imageLinks;

  // Constructor

  DiaryEntry(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.audioLink,
    this.imageLinks,
  );

  // Class properties

  String? get entryId {
    return id;
  }

  String get entryTitle {
    return title;
  }

  String get entryDescription {
    return description;
  }

  DateTime get entryCreatedAt {
    return createdAt;
  }

  // Json Methods

  /// Standard fromJson() method.
  static DiaryEntry fromJson(Map<String, dynamic> jsonResponse) {
    return DiaryEntry(
      jsonResponse['_id'],
      jsonResponse['_title'],
      jsonResponse['_description'].toString(),
      DateTime.parse(jsonResponse['_createdAt']),
      jsonResponse["_audioLink"],
      (jsonResponse["_imageLinks"] == 'None' ||
              jsonResponse["_imageLinks"] == '')
          ? null
          : jsonResponse["_imageLinks"]
              .substring(1, jsonResponse["_imageLinks"].length - 1)
              .replaceAll('\'', '')
              .split(','),
    );
  }

  /// Standard toJson() method.
  static Map<String, dynamic> toJson(DiaryEntry entry) {
    return {
      '_userId': currentUser.userID,
      '_title': entry.title,
      '_description': entry.description,
      '_created_on': entry.createdAt.toIso8601String(),
      '_audioLink': entry.audioLink,
      '_imageLinks':
          (entry.imageLinks != null) ? entry.imageLinks!.join(" ") : "Null",
    };
  }

  /// Helper method to create a [DiaryEntry] in the database.
  static Future<int> createEntry({
    required http.Client createEntryClient,
    required DiaryEntry entry,
  }) async {
    http.Response? response;
    try {
      response = await createEntryClient.post(
        Uri.parse(
          ApiEndpoints.createEntry(currentUser.userID),
        ),
        body: DiaryEntry.toJson(entry),
        headers: currentUser.authHeader(),
      );
      return response.statusCode;
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }

  /// Helper method to update a [DiaryEntry] in the database.
  static Future<int> updateEntry({
    required http.Client updateEntryClient,
    required DiaryEntry entry,
  }) async {
    http.Response? response;
    try {
      response = await updateEntryClient.put(
        Uri.parse(
          ApiEndpoints.updateEntry(currentUser.userID, entry.entryId!),
        ),
        body: DiaryEntry.toJson(entry),
        headers: currentUser.authHeader(),
      );
      return response.statusCode;
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }

  /// Helper method to delete a [DiaryEntry] in the database.
  static Future<int> deleteEntry({
    required http.Client deleteEntryClient,
    required DiaryEntry entry,
  }) async {
    http.Response? response;
    try {
      response = await deleteEntryClient.delete(
        Uri.parse(
          ApiEndpoints.deleteEntry(currentUser.userID, entry.entryId!),
        ),
        headers: currentUser.authHeader(),
      );
      // await FireStorage.deletediaryUploads(entryId: entry.entryId!);
      return response.statusCode;
    } catch (e) {
      log(e.toString());
      return -1;
    }
  }

  /// Helper method to retrieve the entire Diary of a [LyfUser].
  static Future<List<DiaryEntry?>?> getEntries({
    required http.Client getEntryClient,
    required void Function(bool flag) retrieveStatusNotifier,
  }) async {
    http.Response? response;
    List<DiaryEntry>? diary;
    try {
      response = await getEntryClient.get(
        Uri.parse(
          ApiEndpoints.getAllEntries(currentUser.userID),
        ),
        headers: currentUser.authHeader(),
      );
      if (response.statusCode == 200) {
        diary = [];
        json.decode(response.body).forEach((element) {
          DiaryEntry entry = DiaryEntry.fromJson(element);
          diary!.add(entry);
        });
        retrieveStatusNotifier(true);
        return diary;
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

  /// Helper method that saves a [DiaryEntry] as a PDF on the local storage.
  static Future<void> getEntryPdf({
    required http.Client getPdfClient,
    required DiaryEntry entry,
  }) async {
    http.Response? response;
    Directory? _appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    String pdfPath =
        "${_appDocumentsDirectory.path}/${currentUser.username}/diary/${entry.title}.pdf";

    try {
      response = await getPdfClient.get(
        Uri.parse(
          ApiEndpoints.getEntryPdf(currentUser.userID, entry.entryId!),
        ),
        headers: currentUser.authHeader(),
      );
      if (await PermissionManager.requestStorageAccess() == 2) {
        File pdf = File(pdfPath);
        if (pdf.existsSync()) {
          pdf.writeAsBytesSync(response.bodyBytes);
        } else {
          await pdf.create(recursive: true);
          pdf.writeAsBytesSync(response.bodyBytes);
        }

        await OpenFile.open(pdfPath);
      }
    } catch (e) {
      log(e.toString());
    }
  }
  // static Stream<List<DiaryEntry?>?> getEntriesStream(){

  // }
}
