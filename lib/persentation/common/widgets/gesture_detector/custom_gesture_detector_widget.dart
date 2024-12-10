// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomGestureDetectorWidget extends StatelessWidget {

  final MouseCursor mouseCursor;
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Function()? onLongPress;
  final Function()? onLongPressUp;
  final Function(LongPressStartDetails)? onLongPressStart;
  final Function(DragUpdateDetails dragDetails)? onHorizontalDragUpdate;
  final Function(DragStartDetails dragDetails)? onHorizontalDragStart;
  final Function()? onHorizontalDragCancel;
  final Function(DragUpdateDetails dragDetails)? onVerticalDragUpdate;
  final HitTestBehavior? behavior;
  final Function(PointerExitEvent)? onExit;
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerHoverEvent)? onHover;
  final Widget child;

  const CustomGestureDetectorWidget({
    super.key,
    this.mouseCursor = SystemMouseCursors.click,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onLongPressUp,
    this.onLongPressStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragStart,
    this.onHorizontalDragCancel,
    this.onVerticalDragUpdate,
    this.behavior,
    this.onExit,
    this.onEnter,
    this.onHover,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: mouseCursor,
      onExit: onExit,
      onHover: onHover,
      onEnter: onEnter,
      child: GestureDetector(
        behavior: behavior ?? HitTestBehavior.opaque,
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        onLongPress: onLongPress,
        onLongPressUp: onLongPressUp,
        onLongPressStart: onLongPressStart,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragStart: onHorizontalDragStart,
        onHorizontalDragCancel: onHorizontalDragCancel,
        onVerticalDragUpdate: onVerticalDragUpdate,
        child: child,
      ),
    );
  }
}
