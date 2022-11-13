import 'package:firebase_storage/firebase_storage.dart' as firestorage;

class TodoFireStoreServices {
  TodoFireStoreServices._();

  static final firestorage.FirebaseStorage todoStore =
      firestorage.FirebaseStorage.instance;
}
