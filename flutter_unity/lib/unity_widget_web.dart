import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:html' as html;
import 'dart:ui' as ui;

class UnityWidget extends StatefulWidget {
  final PlatformViewCreatedCallback onPlatformViewCreated;

  const UnityWidget({Key key, this.onPlatformViewCreated}) : super(key: key);

  @override
  _UnityWidgetState createState() => _UnityWidgetState();
}

class _UnityWidgetState extends State<UnityWidget> {
  static int id = 0;

  @override
  void initState() {
    id += 1;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'unity_view_$id',
        (int id) => html.IFrameElement()
          ..id = 'unity_view'
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = 'UnityExport/index.html'
          ..style.border = 'none');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(
      viewType: 'unity_view_$id',
    );
  }
}
