import 'dart:developer';

class NoFileException implements Exception {
  String cause;

  NoFileException(this.cause) {
    log(cause);
  }
}

class ImageUploadException implements Exception {
  String cause;

  ImageUploadException(this.cause) {
    log(cause);
  }
}

class AudioUploadException implements Exception {
  String cause;

  AudioUploadException(this.cause) {
    log(cause);
  }
}
