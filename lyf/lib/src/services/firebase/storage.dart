import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firestorage;
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:lyf/src/utils/errors/firestorage_exceptions.dart';
import 'package:lyf/src/global/variables.dart';

class FireStorage {
  static final firestorage.FirebaseStorage storage =
      firestorage.FirebaseStorage.instance;

  static Future<int> uploadDiaryImages({
    required List<PlatformFile?> filesList,
    required String entryId,
    required void Function(List<String> map) notifyImageLinker,
  }) async {
    List<String> linkList = [];
    try {
      for (PlatformFile? file in filesList) {
        Uint8List? compressedFile = await FlutterImageCompress.compressWithFile(
          file!.path!,
          quality: 70,
        );

        firestorage.UploadTask uploadImage = storage
            .ref('${currentUser.userID}/diary/$entryId/images/${file.name}.jpg')
            .putData(compressedFile!);
        linkList.add(await (await uploadImage).ref.getDownloadURL());
      }
      notifyImageLinker(linkList);
      return 1;
    } catch (e) {
      // storage.ref('').putFile(File("path"));
      throw ImageUploadException(e.toString());
    }
  }

  static Future<int> uploadDiaryAudio({
    required PlatformFile? file,
    required String entryId,
    required void Function(String map) notifyAudioLinker,
  }) async {
    String linkAudio;
    try {
      firestorage.UploadTask uploadAudio = storage
          .ref(
              '${currentUser.userID}/diary/$entryId/audio/audio.${file!.extension}')
          .putFile(File(file.path!));
      linkAudio = await ((await uploadAudio).ref.getDownloadURL());
      notifyAudioLinker(linkAudio);
      return 1;
    } catch (e) {
      throw AudioUploadException(e.toString());
    }
  }

  static Future<int> deleteDiaryImages({
    required PlatformFile? file,
    required String entryId,
  }) async {
    try {
      await storage
          .ref('${currentUser.userID}/diary/$entryId/images/')
          .delete();
      return 1;
    } catch (e) {
      throw AudioUploadException(e.toString());
    }
  }

  static Future<int> deleteDiaryAudio({
    required PlatformFile? file,
    required String entryId,
  }) async {
    try {
      await storage.ref('${currentUser.userID}/diary/$entryId/audio/').delete();
      return 1;
    } catch (e) {
      throw AudioUploadException(e.toString());
    }
  }

  static Future<int> deletediaryUploads({
    required String entryId,
  }) async {
    try {
      await storage.ref('${currentUser.userID}/diary/$entryId/').delete();
      return 1;
    } catch (e) {
      return -1;
    }
  }

  static Future<int> diaryUploads({
    required String entryId,
    List<PlatformFile?>? imageFiles,
    PlatformFile? audioFile,
    required void Function(List<String> map) notifyImageLinker,
    required void Function(String map) notifyAudioLinker,
  }) async {
    int statusCode = 0;
    if (imageFiles == null && audioFile == null) {
      // throw NoFileException("No files given");
      return -2;
    } else {
      if (imageFiles != null) {
        statusCode = await uploadDiaryImages(
          filesList: imageFiles,
          entryId: entryId,
          notifyImageLinker: notifyImageLinker,
        );
      }
      if (audioFile != null) {
        statusCode = await uploadDiaryAudio(
          file: audioFile,
          entryId: entryId,
          notifyAudioLinker: notifyAudioLinker,
        );
      }
      return statusCode;
    }
  }

  static Future<int> uploadTodoImages({
    required List<PlatformFile?> filesList,
    required String todoId,
  }) async {
    try {
      for (PlatformFile? file in filesList) {
        await storage
            .ref(
                '${currentUser.userID}/todos/$todoId/images/${file!.name}.${file.extension}')
            .putFile(File(file.path!));
      }
      return 1;
    } catch (e) {
      throw ImageUploadException(e.toString());
    }
  }

  static Future<int> uploadTodoAudio({
    required PlatformFile? file,
    required String todoId,
  }) async {
    try {
      await storage
          .ref(
              '${currentUser.userID}/todos/$todoId/audio/audio.${file!.extension}')
          .putFile(File(file.path!));
      return 1;
    } catch (e) {
      throw AudioUploadException(e.toString());
    }
  }

  static Future<int> downloadDiaryImages({
    required List<PlatformFile?> filesList,
    required String entryId,
  }) async {
    try {
      for (PlatformFile? file in filesList) {
        await storage
            .ref(
                '${currentUser.userID}/diary/$entryId/images/${file!.name}.${file.extension}')
            .putFile(File(file.path!));
      }
      return 1;
    } catch (e) {
      // storage.ref('').putFile(File("path"));
      return -1;
    }
  }

  static Future<int> downloadDiaryAudio({
    required List<PlatformFile?> filesList,
    required String entryId,
  }) async {
    try {
      for (PlatformFile? file in filesList) {
        await storage
            .ref(
                '${currentUser.userID}/diary/$entryId/images/${file!.name}.${file.extension}')
            .putFile(File(file.path!));
      }
      return 1;
    } catch (e) {
      // storage.ref('').putFile(File("path"));
      return -1;
    }
  }
}
