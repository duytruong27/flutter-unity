import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UnityWidget extends StatefulWidget {
  final PlatformViewCreatedCallback onPlatformViewCreated;

  const UnityWidget({Key key, this.onPlatformViewCreated}) : super(key: key);
  
@override
  _UnityWidgetState createState() => _UnityWidgetState();
}

class _UnityWidgetState extends State<UnityWidget> {
  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: 'unity_view',
          onPlatformViewCreated: widget.onPlatformViewCreated,
        );
        break;
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: 'unity_view',
          onPlatformViewCreated: widget.onPlatformViewCreated,
        );
        break;
      default:
        throw UnsupportedError('Unsupported platform: $defaultTargetPlatform');
    }
  }
}