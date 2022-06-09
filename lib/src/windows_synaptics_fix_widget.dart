import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double kDefaultScrollExtent = 20;

/// Fixes Horizontal Scrolling for Synaptics Touchpads on Windows
class WindowsSynapticsFixWidget extends StatefulWidget {
  /// The [ScrollController] which is attached to a horizontally scrollable wheel.
  final ScrollController scrollController;

  /// The extent to which a single scroll event will scroll the [Scrollable] Widget to.
  final double scrollExtentPerScrollEvent;

  /// The child of this widget.
  final Widget child;

  /// This `bool` defines if the user needs to press shift while horizontally scrolling.
  ///
  /// Defaults to `false`
  final bool shouldPressShiftWhileHorizontalScroll;

  const WindowsSynapticsFixWidget({
    Key? key,
    required this.scrollController,
    required this.child,
    this.scrollExtentPerScrollEvent = kDefaultScrollExtent,
    this.shouldPressShiftWhileHorizontalScroll = false,
  }) : super(key: key);

  @override
  State<WindowsSynapticsFixWidget> createState() =>
      _WindowsSynapticsFixWidgetState();
}

class _WindowsSynapticsFixWidgetState extends State<WindowsSynapticsFixWidget> {
  final FocusNode focusNode = FocusNode();
  late double scrollExtent;
  late ScrollController controller;
  late bool _shouldEnable;

  @override
  void initState() {
    super.initState();
    scrollExtent = widget.scrollExtentPerScrollEvent;
    controller = widget.scrollController;
    _shouldEnable = defaultTargetPlatform == TargetPlatform.windows;
  }

  @override
  Widget build(BuildContext context) {
    return _shouldEnable
        ? RawKeyboardListener(
            onKey: (event) => _onRawKey(event),
            focusNode: focusNode,
            child: widget.child,
          )
        : widget.child;
  }

  _onRawKey(RawKeyEvent rawKeyEvent) {
    if (_shouldEnable) {
      assert(controller.hasClients,
          'Controller Must be attached to a ScrollView or a Scrollable Widget.');
      assert(controller.position.axis == Axis.horizontal,
          'This plugin provides fixes for horizontal Scrolling only. Hence, the controller must be attached to a ScrollView with ScrollDirection being Axis.horizontal only.');
      var rawEvent = (rawKeyEvent.data as RawKeyEventDataWindows);

      double offset;
      if ((rawEvent.logicalKey == LogicalKeyboardKey.arrowLeft ||
              rawEvent.logicalKey == LogicalKeyboardKey.arrowRight) &&
          rawEvent.scanCode == 0 &&
          (widget.shouldPressShiftWhileHorizontalScroll
              ? rawEvent.isShiftPressed
              : true)) {
        if (rawEvent.logicalKey == LogicalKeyboardKey.arrowLeft) {
          var newOffset = controller.offset - scrollExtent;
          offset =
              newOffset > controller.position.minScrollExtent ? newOffset : 0;
        } else {
          var newOffset = controller.offset + scrollExtent;
          offset = newOffset < controller.position.maxScrollExtent
              ? newOffset
              : controller.position.maxScrollExtent;
        }
        controller.jumpTo(
          offset,
        );
      }
    }
  }
}
