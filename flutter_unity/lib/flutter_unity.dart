import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unity_platform_interface/flutter_unity_platform_interface.dart';

import 'unity_widget_mobile.dart' if (dart.library.html) 'unity_widget_web.dart'
    as multiPlatform;

class UnityViewController {
  UnityViewController._(
    UnityView view,
    int id,
  )   : _view = view,
        _channel = MethodChannel('unity_view_$id') {
    _channel.setMethodCallHandler(_methodCallHandler);
  }

  UnityView _view;
  final MethodChannel _channel;

  Future<dynamic> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'onUnityViewReattached':
        if (_view.onReattached != null) {
          _view.onReattached(this);
        }
        return null;
      case 'onUnityViewMessage':
        if (_view.onMessage != null) {
          _view.onMessage(this, call.arguments);
        }
        return null;
      default:
        throw UnimplementedError('Unimplemented method: ${call.method}');
    }
  }

  void pause() {
    FlutterUnityPlatform.instance.pause();
  }

  void resume() {
    FlutterUnityPlatform.instance.resume();
  }

  void send(
    String gameObjectName,
    String methodName,
    String message,
  ) {
    FlutterUnityPlatform.instance.send(gameObjectName, methodName, message);
  }
}

typedef void UnityViewCreatedCallback(
  UnityViewController controller,
);
typedef void UnityViewReattachedCallback(
  UnityViewController controller,
);
typedef void UnityViewMessageCallback(
  UnityViewController controller,
  String message,
);

class UnityView extends StatefulWidget {
  const UnityView({
    Key key,
    this.onCreated,
    this.onReattached,
    this.onMessage,
  }) : super(key: key);

  final UnityViewCreatedCallback onCreated;
  final UnityViewReattachedCallback onReattached;
  final UnityViewMessageCallback onMessage;

  @override
  _UnityViewState createState() => _UnityViewState();
}

class _UnityViewState extends State<UnityView> {
  UnityViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(UnityView oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller?._view = widget;
  }

  @override
  void dispose() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      controller?._channel?.invokeMethod('dispose');
    }
    controller?._channel?.setMethodCallHandler(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return multiPlatform.UnityWidget(
      onPlatformViewCreated: onPlatformViewCreated,
    );
  }

  void onPlatformViewCreated(int id) {
    controller = UnityViewController._(widget, id);
    if (widget.onCreated != null) {
      widget.onCreated(controller);
    }
  }
}
