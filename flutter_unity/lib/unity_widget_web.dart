import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'dart:html' as html;
import 'dart:ui' as ui;


class UnityWidget extends StatefulWidget {
  final PlatformViewCreatedCallback onPlatformViewCreated;

  const UnityWidget({Key key, this.onPlatformViewCreated}) : super(key: key);

  @override
  _UnityWidgetState createState() => _UnityWidgetState();
}

class _UnityWidgetState extends State<UnityWidget> {
  String viewId = 'unity_view';

  @override
  void initState() {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        viewId,
        (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = 'UnityExport/index.html'
          ..style.border = 'none');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Webview();
  }
}

