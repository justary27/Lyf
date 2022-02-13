import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AudioViewer extends StatefulWidget {
  final Size size;
  final PlatformFile audioFile;
  final void Function(Key key) removeMethod;
  final void Function(bool flag) notifyflagChange;
  final void Function(PlatformFile? file) fileHandler;
  const AudioViewer({
    required this.size,
    required this.audioFile,
    required this.removeMethod,
    required this.notifyflagChange,
    required this.fileHandler,
  }) : super(
          key: const Key('audioAttachment'),
        );

  @override
  _AudioViewerState createState() => _AudioViewerState();
}

class _AudioViewerState extends State<AudioViewer> {
  Widget audioViewer({
    required Size size,
    required PlatformFile audioFile,
    required void Function(Key key) removeMethod,
    required void Function(bool flag) notifyflagChange,
    required void Function(PlatformFile? file) fileHandler,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      audioFile.name,
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        notifyflagChange(false);
                        removeMethod(const Key('audioAttachment'));
                        fileHandler(null);
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                ListTile(
                  isThreeLine: true,
                  leading: Container(
                    height: 50,
                    width: 50,
                    color: Colors.white.withOpacity(0.35),
                    child: Icon(
                      Icons.music_note_rounded,
                      color: Colors.white,
                    ),
                  ),
                  title: Divider(
                    color: Colors.white,
                    height: 4,
                  ),
                  subtitle: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return audioViewer(
      size: widget.size,
      audioFile: widget.audioFile,
      removeMethod: widget.removeMethod,
      notifyflagChange: widget.notifyflagChange,
      fileHandler: widget.fileHandler,
    );
  }
}

Future<Widget?> audioPickerLauncher({
  required Future<int> Function() requestStorageAccess,
  required Size size,
  required void Function(Key key) removeMethod,
  required void Function(bool flag) notifyflagChange,
  required void Function(PlatformFile? file) fileServer,
}) async {
  int? requestResponse;
  requestResponse = await requestStorageAccess();
  print(requestResponse);
  if (requestResponse == 2) {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);
    if (result == null) {
      return null;
    } else {
      PlatformFile audioFile = result.files.first;
      // Uint8List? fileBytes = file.bytes;
      notifyflagChange(true);
      fileServer(audioFile);
      return AudioViewer(
        size: size,
        audioFile: audioFile,
        removeMethod: removeMethod,
        notifyflagChange: notifyflagChange,
        fileHandler: fileServer,
      );
    }
  } else {
    return null;
  }
}
