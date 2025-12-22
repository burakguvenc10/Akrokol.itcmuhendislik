import 'package:flutter/material.dart';
import '../Component/Webview_item.dart';

class Webview extends StatefulWidget {
  @override
  _WebviewPage createState() => _WebviewPage();
}

class _WebviewPage extends State<Webview> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Expanded(
              child: Webview_item(),
            ),
          ],
        ),
    );
  }
}