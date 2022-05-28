import 'dart:io';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:json_annotation/json_annotation.dart';
import '../interface/json_object.dart';
import '../global/globals.dart';
import '../utils/handlers/permission_handler.dart';
import '../services/http.dart';

part 'diary_model.g.dart';

/// ## Diary
/// Defining class of an entry in diary of a [LyfUser].
@JsonSerializable()
class DiaryEntry extends JsonObject {
  /// Unique Id of a [DiaryEntry]
  @JsonKey(name: "_id")
  final String? id;

  /// Title of a [DiaryEntry]
  @JsonKey(name: "_title")
  final String title;

  /// Description of a [DiaryEntry]
  @JsonKey(name: "_description")
  final String description;

  /// Time when the [DiaryEntry] was created
  @JsonKey(name: "_createdAt")
  final DateTime createdAt;

  /// Url of an audioFile attached with the [DiaryEntry]
  @JsonKey(name: "_audioLink")
  String? audioLink;

  /// A list of urls attached with the [DiaryEntry]
  @JsonKey(name: "_imageLinks")
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

  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DiaryEntryToJson(this);

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
        // body: DiaryEntry.toJson(entry),
        headers: currentUser.authHeader(),
      );
      return response.statusCode;
    } catch (e) {
      log(e.toString());
      return -1;
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
