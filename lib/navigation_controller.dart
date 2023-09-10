import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class NavigationController extends StatelessWidget {
  const NavigationController({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final webViewController = snapshot.data;
          if (webViewController != null) {
            return Row(
              children: [
                IconButton(
                  onPressed: () async {
                    if (await webViewController.canGoBack()) {
                      await webViewController.goBack();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No back history')));
                    }
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                IconButton(
                  onPressed: () async {
                    if (await webViewController.canGoForward()) {
                      await webViewController.goForward();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No forward history')));
                    }
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
                IconButton(
                  onPressed: () async {
                    webViewController.reload();
                  },
                  icon: Icon(Icons.reply),
                ),
              ],
            );
          }
        }
        // If the Future is still running or webViewController is null, show a loading indicator.
        return CircularProgressIndicator();
      },
    );
  }
}