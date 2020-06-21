import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_unity_platform_interface/flutter_unity_platform_interface.dart';
import 'dart:js' as js;

/// An implementation of [FlutterUnityPlatform] that uses method channels.
class FlutterUnityPlugin extends FlutterUnityPlatform {
  static void registerWith(Registrar registrar) {
    FlutterUnityPlatform.instance = FlutterUnityPlugin();
  }

  @override
  void pause() {
    // js.context.callMethod('pause');
  }

  @override
  void resume() {
    // js.context.callMethod('resume');
  }

  @override
  void send(String gameObjectName, String methodName, String message) {
    js.context.callMethod('sendToUnity', [gameObjectName, methodName, message]);
  }
}