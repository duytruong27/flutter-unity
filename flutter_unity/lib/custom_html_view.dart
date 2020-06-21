// should be removed later when this is done:
// https://github.com/flutter/flutter/issues/56181

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/gestures.dart';

import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;


class CustomHtmlElementView extends StatelessWidget {
  final String viewType;
  final PlatformViewCreatedCallback onPlatformViewCreated;
  final dynamic creationParams;

  const CustomHtmlElementView({Key key, @required this.viewType, this.onPlatformViewCreated, this.creationParams})
      : assert(viewType != null),
        assert(kIsWeb, 'HtmlElementView is only available on Flutter Web.'),
        super(key: key);

  @override
  Widget build(BuildContext context) => PlatformViewLink(
        viewType: viewType,
        onCreatePlatformView: _createHtmlElementView,
        surfaceFactory: (BuildContext context, PlatformViewController controller) => PlatformViewSurface(
          controller: controller,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        ),
      );

  _CustomHtmlElementViewController _createHtmlElementView(PlatformViewCreationParams params) {
    final _CustomHtmlElementViewController controller = _CustomHtmlElementViewController(params.id, viewType);
    controller._initialize().then((_) {
      params.onPlatformViewCreated(params.id);
      onPlatformViewCreated(params.id); //!!!
    });
    return controller;
  }
}

class _CustomHtmlElementViewController extends PlatformViewController {
  _CustomHtmlElementViewController(
    this.viewId,
    this.viewType,
  );

  @override
  final int viewId;

  /// The unique identifier for the HTML view type to be embedded by this widget.
  ///
  /// A PlatformViewFactory for this type must have been registered.
  final String viewType;

  bool _initialized = false;

  Future<void> _initialize() async {
    final Map<String, dynamic> args = <String, dynamic>{
      'id': viewId,
      'viewType': viewType,
    };
    await SystemChannels.platform_views.invokeMethod<void>('create', args);
    _initialized = true;
  }

  @override
  void clearFocus() {
    // Currently this does nothing on Flutter Web.
    // TODO(het): Implement this. See https://github.com/flutter/flutter/issues/39496
  }

  @override
  void dispatchPointerEvent(PointerEvent event) {
    // We do not dispatch pointer events to HTML views because they may contain
    // cross-origin iframes, which only accept user-generated events.
  }

  @override
  void dispose() {
    if (_initialized) {
      // Asynchronously dispose this view.
      SystemChannels.platform_views.invokeMethod<void>('dispose', viewId);
    }
  }
}