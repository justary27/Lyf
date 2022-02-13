import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatefulWidget {
  final Size size;
  final List<PlatformFile?> imageFiles;
  final void Function(Key key) removeMethod;
  final void Function(bool flag) notifyflagChange;
  final void Function(List<PlatformFile?>? file) fileHandler;

  const ImageViewer({
    Key? key,
    required this.size,
    required this.imageFiles,
    required this.removeMethod,
    required this.notifyflagChange,
    required this.fileHandler,
  }) : super(
          key: const Key('imageAttachment'),
        );

  @override
  _ImageViewerState createState() => _ImageViewerState();
}

class _ImageViewerState extends State<ImageViewer> {
  Widget imageViewer({
    required Size size,
    required List<PlatformFile?> imageFiles,
    required void Function(Key key) removeMethod,
    required void Function(bool flag) notifyflagChange,
    required void Function(List<PlatformFile?>? file) fileHandler,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 0.05 * size.width,
        vertical: 0.015 * size.height,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: Colors.white.withOpacity(0.15),
        child: SizedBox(
          width: 0.9 * size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 0.05 * size.width, vertical: 0.01 * size.height),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (imageFiles.length > 1)
                        ? Text(
                            "Images",
                            style: TextStyle(color: Colors.white),
                          )
                        : Text(
                            "Image",
                            style: TextStyle(color: Colors.white),
                          ),
                    IconButton(
                      onPressed: () {
                        notifyflagChange(false);
                        removeMethod(const Key('imageAttachment'));
                        fileHandler(null);
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.4 * size.height,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (imageFiles.length > 2) ? 2 : 1,
                    ),
                    itemCount: imageFiles.length,
                    itemBuilder: (context, index) {
                      File image = File(imageFiles[index]!.path!);
                      return Card(
                        color: Colors.white.withOpacity(0.15),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Ink.image(
                          fit: BoxFit.cover,
                          image: FileImage(
                            image,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return imageViewer(
        size: widget.size,
        imageFiles: widget.imageFiles,
        removeMethod: widget.removeMethod,
        notifyflagChange: widget.notifyflagChange,
        fileHandler: widget.fileHandler);
  }
}

Future<Widget?> imagePickerLauncher({
  required Future<int> Function() requestStorageAccess,
  required Size size,
  required void Function(Key key) removeMethod,
  required void Function(bool flag) notifyflagChange,
  required void Function(List<PlatformFile?>? files) fileServer,
}) async {
  int? requestResponse;
  List<PlatformFile?>? imageFiles;
  requestResponse = await requestStorageAccess();
  if (requestResponse == 2) {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (result == null) {
      return null;
    } else {
      imageFiles = result.files;
      print(result.names);
      notifyflagChange(true);
      fileServer(imageFiles);
      return ImageViewer(
        size: size,
        imageFiles: imageFiles,
        removeMethod: removeMethod,
        notifyflagChange: notifyflagChange,
        fileHandler: fileServer,
      );
    }
  } else {
    return null;
  }
}
