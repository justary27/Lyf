import 'package:firebase_storage/firebase_storage.dart' as firestorage;

class DiaryFireStoreServices {
  DiaryFireStoreServices._();

  static final firestorage.FirebaseStorage diaryStore =
      firestorage.FirebaseStorage.instance;
}
