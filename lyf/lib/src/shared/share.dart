import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lyf/src/models/diary_model.dart';
import 'package:lyf/src/state/diary/diary_list_state.dart';
import 'package:share_plus/share_plus.dart';

import '../global/variables.dart';

class ShareViewer extends ConsumerStatefulWidget {
  final Size size;
  final DiaryEntry entry;
  final Color color;
  const ShareViewer({
    Key? key,
    required this.size,
    required this.entry,
    required this.color,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ShareViewerState();
}

class _ShareViewerState extends ConsumerState<ShareViewer> {
  late bool isPrivate = true;

  Future<void> _changeEntryVisibility(bool value) async {}

  void _shareEntryLink() {
    Share.share(
      "incognos.page.link/lyf/${currentUser.userId}/diary/${widget.entry.id}",
      subject: "Check out my experience ${widget.entry.title}",
    );
  }

  Function()? _buildShareAction() {
    return isPrivate ? null : () => _shareEntryLink();
  }

  @override
  void initState() {
    super.initState();
    isPrivate = widget.entry.isPrivate;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        width: 0.75 * widget.size.width,
        height: 0.45 * widget.size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share "${widget.entry.title}"',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                color: widget.color,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Online Sharing",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                color: widget.color.withOpacity(0.75),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Visibility:",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyText1!.fontSize,
                    color: widget.color.withOpacity(0.75),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 0.75 * widget.size.width - 40,
              child: TextButton.icon(
                onPressed: _buildShareAction,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    widget.color.withOpacity(0.5),
                  ),
                ),
                icon: Icon(
                  Icons.link_rounded,
                  color: Theme.of(context).iconTheme.color,
                ),
                label: Text(
                  "Share Link",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Offline Sharing",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                color: widget.color.withOpacity(0.75),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 0.3 * widget.size.width,
                  child: TextButton(
                    onPressed: () {
                      Share.share(
                        "${widget.entry.entryTitle}\n\n${widget.entry.entryDescription}\n\nDated:${widget.entry.entryCreatedAt.day}/${widget.entry.entryCreatedAt.month}/${widget.entry.entryCreatedAt.year}",
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        widget.color.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      "Share as Text",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 0.3 * widget.size.width,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        widget.color.withOpacity(0.5),
                      ),
                    ),
                    child: Text(
                      "Share as Pdf",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
