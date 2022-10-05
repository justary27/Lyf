import 'dart:io';
import 'dart:developer';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import './permission_handler.dart';
import '../../global/variables.dart';
import '../../models/diary_model.dart';

class FileHandler {
  FileHandler._();
  static Future<void> saveDiaryPdf(Uint8List? int8List) async {
    Directory? _appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    String pdfPath =
        "${_appDocumentsDirectory.path}/${currentUser.username}/${currentUser.userName}_diary.pdf";

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
      log(e.toString());
    }
  }

  static Future<void> saveDiaryTxt(Uint8List? int8List) async {
    Directory? _appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    String txtPath =
        "${_appDocumentsDirectory.path}/${currentUser.username}/${currentUser.userName}_diary.txt";

    try {
      if (await PermissionManager.requestStorageAccess() == 2) {
        File txt = File(txtPath);

        if (txt.existsSync()) {
          txt.writeAsBytesSync(int8List!);
        } else {
          await txt.create(recursive: true);
          txt.writeAsBytesSync(int8List!);
        }
        await OpenFile.open(txtPath);
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

  static Future<void> saveEntryTxt(
      DiaryEntry entry, Uint8List? int8List) async {
    Directory? _appDocumentsDirectory =
        await getApplicationDocumentsDirectory();
    String txtPath =
        "${_appDocumentsDirectory.path}/${currentUser.username}/diary/${entry.title}.txt";

    try {
      if (await PermissionManager.requestStorageAccess() == 2) {
        File txt = File(txtPath);

        if (txt.existsSync()) {
          txt.writeAsBytesSync(int8List!);
        } else {
          await txt.create(recursive: true);
          txt.writeAsBytesSync(int8List!);
        }
        await OpenFile.open(txtPath);
      }
    } catch (e) {
      log("txt error");
      rethrow;
    }
  }

  static Future<PlatformFile?> pickAudioFile() async {
    int? requestResponse = await PermissionManager.requestStorageAccess();

    if (requestResponse == 2) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (result == null) {
        return null;
      } else {
        PlatformFile audioFile = result.files.first;
        return audioFile;
      }
    } else {
      return null;
    }
  }

  static Future<List<PlatformFile>?> pickImages() async {
    int? requestResponse = await PermissionManager.requestStorageAccess();
    if (requestResponse == 2) {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);
      if (result == null) {
        return null;
      } else {
        return result.files;
      }
    } else {
      return null;
    }
  }
}
