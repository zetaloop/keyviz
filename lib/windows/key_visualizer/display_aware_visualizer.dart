import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';

import 'package:keyviz/providers/key_event.dart';

import 'key_visualizer.dart';

class DisplayAwareVisualizer extends StatelessWidget {
  const DisplayAwareVisualizer({super.key});

  @override
  Widget build(BuildContext context) {
    final keyEvent = context.read<KeyEventProvider>();
    final idx = context.select<KeyEventProvider, int>((p) => p.screenIndex);
    final screens = keyEvent.screens;

    if (idx == -2 && screens.length > 1) {
      // 所有屏幕（逐屏）：在每个屏幕区域各放置一个 KeyVisualizer
      final frame = _allScreensFrame(screens);
      final dpr = ui.PlatformDispatcher.instance.implicitView?.devicePixelRatio ??
          (ui.PlatformDispatcher.instance.views.isNotEmpty
              ? ui.PlatformDispatcher.instance.views.first.devicePixelRatio
              : 1.0);

      return Stack(
        children: [
          for (final s in screens)
            Positioned(
              left: (s.frame.left - frame.left) / dpr,
              top: (s.frame.top - frame.top) / dpr,
              width: s.frame.width / dpr,
              height: s.frame.height / dpr,
              child: const IgnorePointer(child: KeyVisualizer()),
            ),
        ],
      );
    }

    // 单屏或所有屏幕（合并）：单个可视化组件基于整个窗口
    return const KeyVisualizer();
  }

  Rect _allScreensFrame(List<Screen> screens) {
    if (screens.isEmpty) return const Rect.fromLTWH(0, 0, 0, 0);
    double left = screens.first.frame.left;
    double top = screens.first.frame.top;
    double right = screens.first.frame.right;
    double bottom = screens.first.frame.bottom;
    for (final s in screens) {
      if (s.frame.left < left) left = s.frame.left;
      if (s.frame.top < top) top = s.frame.top;
      if (s.frame.right > right) right = s.frame.right;
      if (s.frame.bottom > bottom) bottom = s.frame.bottom;
    }
    return Rect.fromLTRB(left, top, right, bottom);
  }
}
