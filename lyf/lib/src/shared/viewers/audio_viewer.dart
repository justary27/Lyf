import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/diary/diary_view_state.dart';

class AudioViewer extends ConsumerStatefulWidget {
  final Size size;
  final PlatformFile? audioFile;
  final void Function(bool flag) notifyflagChange;
  final void Function(PlatformFile? file) fileHandler;
  final List<Widget>? stateWidgetList;
  final String? audioUrl;
  const AudioViewer({
    required this.size,
    required this.notifyflagChange,
    required this.fileHandler,
    this.audioFile,
    this.stateWidgetList,
    this.audioUrl,
  }) : super(
          key: const Key('audioAttachment'),
        );

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AudioViewerState();
}

class _AudioViewerState extends ConsumerState<AudioViewer> {
  void _removeAudioAttachment() {
    if (widget.audioUrl != null) {
      ref
          .read(diaryViewNotifier(widget.stateWidgetList!).notifier)
          .deleteAudioAttachment(
            notifyflagChange: widget.notifyflagChange,
            notify: true,
          );
    } else {
      ref
          .read(diaryViewNotifier(widget.stateWidgetList!).notifier)
          .deleteAudioAttachment(
            notifyflagChange: widget.notifyflagChange,
          );
    }
  }

  Widget audioViewer({
    required Size size,
    PlatformFile? audioFile,
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
                      audioFile != null ? audioFile.name : "AudioFile",
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {
                        notifyflagChange(false);
                        _removeAudioAttachment();
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
      notifyflagChange: widget.notifyflagChange,
      fileHandler: widget.fileHandler,
    );
  }
}
