import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewer extends ConsumerStatefulWidget {
  final String initialUrl;
  const WebViewer({
    super.key,
    required this.initialUrl,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WebViewerState();
}

class _WebViewerState extends ConsumerState<WebViewer> {
  @override
  Widget build(BuildContext context) {

    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
    return SafeArea(
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
