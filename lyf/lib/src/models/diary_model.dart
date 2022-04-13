import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lyf/src/global/globals.dart';
import 'package:lyf/src/services/firebase/storage.dart';
import 'package:lyf/src/services/http.dart';

class DiaryEntry {
  final String? id;
  final String title;
  final String description;
  final DateTime createdAt;
  String? audioLink;
  List<String>? imageLinks;

  DiaryEntry(
    this.id,
    this.title,
    this.description,
    this.createdAt,
    this.audioLink,
    this.imageLinks,
  );
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

  static DiaryEntry fromJson(Map<String, dynamic> jsonResponse) {
    print(jsonResponse["_imageLinks"]);
    return DiaryEntry(
      jsonResponse['_id'],
      jsonResponse['_title'],
      jsonResponse['_description'].toString(),
      DateTime.parse(jsonResponse['_createdAt']),
      jsonResponse["_audioLink"],
      (jsonResponse["_imageLinks"] != 'Null')
          ? jsonResponse["_imageLinks"]
              .substring(1, jsonResponse["_imageLinks"].length - 1)
              .replaceAll('\'', '')
              .split(',')
          : null,
    );
  }

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
      print(e);
      return -1;
    }
  }

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
      print(e);
      return -1;
    }
  }

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
      print(e);
      return -1;
    }
  }

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
      print(e);
      retrieveStatusNotifier(false);
      return [null];
    }
  }

  // static Stream<List<DiaryEntry?>?> getEntriesStream(){

  // }
}
