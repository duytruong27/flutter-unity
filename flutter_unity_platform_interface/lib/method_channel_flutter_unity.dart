import 'package:flutter/services.dart';
import 'flutter_unity_platform_interface.dart';

/// An implementation of [FlutterUnityPlatform] that uses method channels.
class MethodChannelFlutterUnity extends FlutterUnityPlatform {
  static MethodChannel channel =
      MethodChannel('plugins.flutter.io/flutter_unity');

  @override
  void pause() {
    channel.invokeMethod<void>('pause');
  }

  @override
  void resume() {
    channel.invokeMethod<void>('resume');
  }

  @override
  void send(String gameObjectName, String methodName, String message) {
    channel.invokeMethod('send', {
      'gameObjectName': gameObjectName,
      'methodName': methodName,
      'message': message,
    });
  }
}
