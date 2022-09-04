import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/diary/diary_view_state.dart';

class ImageViewer extends ConsumerStatefulWidget {
  final Size size;
  final List<PlatformFile?>? imageFiles;
  final void Function(bool flag) notifyflagChange;
  final void Function(List<PlatformFile?>? file) fileHandler;
  final void Function() onValueDelete;
  final List<String>? imageUrls;
  final List<Widget>? stateWidgetList;
  const ImageViewer({
    Key? key,
    required this.size,
    required this.notifyflagChange,
    required this.fileHandler,
    required this.onValueDelete,
    this.imageFiles,
    this.imageUrls,
    this.stateWidgetList,
  }) : super(
          key: const Key('imageAttachment'),
        );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImageViewerState();
}

class _ImageViewerState extends ConsumerState<ImageViewer> {
  void _removeImageAttachments() {
    if (widget.imageUrls != null) {
      ref
          .read(diaryViewNotifier(widget.stateWidgetList!).notifier)
          .deleteImageAttachments(
            notifyflagChange: widget.notifyflagChange,
            notify: true,
            onValueDelete: widget.onValueDelete,
          );
    } else {
      ref
          .read(diaryViewNotifier(widget.stateWidgetList!).notifier)
          .deleteImageAttachments(
            notifyflagChange: widget.notifyflagChange,
          );
    }
  }

  Widget imageViewer({
    required Size size,
    required void Function(bool flag) notifyflagChange,
    required void Function(List<PlatformFile?>? file) fileHandler,
    List<PlatformFile?>? imageFiles,
    List<String>? imageUrls,
  }) {
    late int itemCount;
    if (imageFiles != null) {
      itemCount = imageFiles.length;
    } else if (imageUrls != null) {
      itemCount = imageUrls.length;
    }
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
                    (itemCount > 1)
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
                        fileHandler(null);
                        _removeImageAttachments();
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
                      crossAxisCount: (itemCount > 2) ? 2 : 1,
                    ),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      late File image;
                      if (imageFiles != null) {
                        image = File(imageFiles[index]!.path!);
                      }
                      return Card(
                        color: Colors.white.withOpacity(0.15),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: (imageUrls != null)
                            ? Ink.image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  imageUrls[index].trimLeft(),
                                ),
                              )
                            : Ink.image(
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
      notifyflagChange: widget.notifyflagChange,
      fileHandler: widget.fileHandler,
      imageUrls: widget.imageUrls,
    );
  }
}
