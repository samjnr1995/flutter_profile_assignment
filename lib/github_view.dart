import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'navigation_controller.dart';

class GitHubView extends StatefulWidget {
  const GitHubView({required this.controller, Key? key}) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  State<GitHubView> createState() => _GitHubViewState();
}

class _GitHubViewState extends State<GitHubView> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          NavigationController(controller: widget.controller),
        ],
        title: const Text('GitHub Profile'),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: 'https://github.com/samjnr1995', // Replace with your GitHub repository URL
            onWebViewCreated: (webViewController) {
              widget.controller.complete(webViewController);
            },
            onPageStarted: (url) {
              setState(() {
                loadingPercentage = 0;
              });
            },
            onProgress: (progress) {
              setState(() {
                loadingPercentage = progress;
              });
            },
            onPageFinished: (url) {
              setState(() {
                loadingPercentage = 100;
              });
            },
          ),
          if (loadingPercentage < 100)
            Center(
              child: CircularProgressIndicator(
                value: loadingPercentage / 100.0,
                strokeWidth: 4.0, // Adjust the thickness of the progress indicator
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
        ],
      ),
    );
  }
}
