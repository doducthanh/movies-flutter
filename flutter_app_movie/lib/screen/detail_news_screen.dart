import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterappmovie/const/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailNewsPage extends StatefulWidget {
  final url;

  DetailNewsPage(this.url);

  @override
  _DetailNewsPageState createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MAIN_THEME,
      ),
      body: IndexedStack(
        index: index,
        children: <Widget>[
          LinearProgressIndicator(),
          Builder(builder: (BuildContext context) {
            return WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (text) {
                setState(() {
                  index = 1;
                });
              },
            );
          })
        ],
      ),
    );
  }
}
