import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends ConsumerStatefulWidget {
  final String initialUrl;
  const WebViewer({
    Key? key,
    required this.initialUrl,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewerState();
}

class _WebViewerState extends ConsumerState<WebViewer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: widget.initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
