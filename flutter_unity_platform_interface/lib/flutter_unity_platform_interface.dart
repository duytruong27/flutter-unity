import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'method_channel_flutter_unity.dart';

/// The interface that implementations of flutter_unity must implement.
///
/// Platform implementations should extend this class rather than implement it as `flutter_unity`
/// does not consider newly added methods to be breaking changes. Extending this class
/// (using `extends`) ensures that the subclass will get the default implementation, while
/// platform implementations that `implements` this interface will be broken by newly added
/// [FlutterUnityPlatform] methods.
abstract class FlutterUnityPlatform extends PlatformInterface {
  /// Constructs a UrlLauncherPlatform.
  FlutterUnityPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUnityPlatform _instance = MethodChannelUrlLauncher();

  /// The default instance of [UrlLauncherPlatform] to use.
  ///
  /// Defaults to [MethodChannelUrlLauncher].
  static FlutterUnityPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [FlutterUnityPlatform] when they register themselves.
 
  static set instance(FlutterUnityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Pause unity game
  void pause() {
    throw UnimplementedError('pause() has not been implemented.');
  }

  /// Resume unity game
  void resume() {
    throw UnimplementedError('resume() has not been implemented.');
  }

  /// Send message to unity.
  void send(
    String gameObjectName,
    String methodName,
    String message,
  ) {
    throw UnimplementedError('send() has not been implemented.');
  }
}