import 'package:flutter/services.dart';
import 'flutter_unity_platform_interface.dart';

const MethodChannel _channel = MethodChannel('plugins.flutter.io/flutter_unity');

/// An implementation of [FlutterUnityPlatform] that uses method channels.
class MethodChannelUrlLauncher extends FlutterUnityPlatform {
  @override
  void pause() {
    _channel.invokeMethod<void>('pause');
  }

  @override
  void resume() {
    _channel.invokeMethod<void>('resume');
  }

  @override
  void send(String gameObjectName, String methodName, String message) {
    _channel.invokeMethod('send', {
      'gameObjectName': gameObjectName,
      'methodName': methodName,
      'message': message,
    });
  }
}