import 'dart:io';
import 'dart:developer';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import './permission_handler.dart';
import '../../global/globals.dart';
import '../../models/diary_model.dart';

class FileHandler {
  FileHandler._();
  static Future<void> saveDiaryPdf(Uint8List int8List) async {
    Directory? _appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    String pdfPath =
        "${_appDocumentsDirectory.path}/${currentUser.username}/${currentUser.userName}s diary.pdf";

    try {
      if (await PermissionManager.requestStorageAccess() == 2) {
        File pdf = File(pdfPath);

        if (pdf.existsSync()) {
          pdf.writeAsBytesSync(int8List);
        } else {
          await pdf.create(recursive: true);
          pdf.writeAsBytesSync(int8List);
        }
        await OpenFile.open(pdfPath);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> saveEntryPdf(
      DiaryEntry entry, Uint8List? int8List) async {
    Directory? _appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    String pdfPath =
        "${_appDocumentsDirectory.path}/${currentUser.username}/diary/${entry.title}.pdf";

    try {
      if (await PermissionManager.requestStorageAccess() == 2) {
        File pdf = File(pdfPath);

        if (pdf.existsSync()) {
          pdf.writeAsBytesSync(int8List!);
        } else {
          await pdf.create(recursive: true);
          pdf.writeAsBytesSync(int8List!);
        }
        await OpenFile.open(pdfPath);
      }
    } catch (e) {
      log("pdf error");
      rethrow;
    }
  }
}
