import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firestorage;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../../../utils/errors/firebase/firestore_errors.dart';

import '../../../global/variables.dart';

class UserFireStoreServices {
  UserFireStoreServices._();

  static final firestorage.FirebaseStorage userStore =
      firestorage.FirebaseStorage.instance;

  static getPfpLink() async {
    try {
      currentUser.pfpLink =
          await userStore.ref("${currentUser.userId}/pfp.jpg").getDownloadURL();
    } catch (e) {
      log(e.toString());
      throw FireStoreException(e.toString());
    }
  }

  static Future uploadPfp(PlatformFile img) async {
    try {
      File? compressedFile = await FlutterImageCompress.compressAndGetFile(
        img.path!,
        img.path!,
        quality: 70,
      );
      firestorage.UploadTask uploadPfp =
          userStore.ref("${currentUser.userId}/pfp.jpg").putFile(
                compressedFile!,
              );

      currentUser.pfpLink = await (await uploadPfp).ref.getDownloadURL();
    } catch (e) {
      throw FireStoreException(e.toString());
    }
  }

  static Future deletePfp() async {
    try {
      await userStore.ref("${currentUser.userId}/pfp.jpg").delete();
    } catch (e) {
      throw FireStoreException(e.toString());
    }
  }
}
