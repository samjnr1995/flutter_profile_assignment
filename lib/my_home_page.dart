import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'github_view.dart';
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String slackName = "samjnr,";
  final String slackDpPath = "assets/sam.jpg";
  Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text('My Slack profile',style: TextStyle(fontSize: 20), ),
              Text(
                slackName,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(height: 16),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage(slackDpPath),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GitHubView(controller: controller,),
                    ),
                  ).then((_) {
                    // Clear the controller when the GitHub view is closed
                    controller = Completer<WebViewController>();
                  });
                },
                child: Text('Open GitHub'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}