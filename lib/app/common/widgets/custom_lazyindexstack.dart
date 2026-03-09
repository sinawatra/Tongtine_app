import 'package:flutter/material.dart';

/// A widget that behaves like [IndexedStack] but only builds its children
/// when they are activated (indexed) for the first time.
class LazyIndexedStack extends StatefulWidget {
  const LazyIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
  });

  /// The index of the child to show.
  final int index;

  /// The list of children widgets.
  final List<Widget> children;

  /// How to align the non-positioned and partially-positioned children in the
  /// stack.
  final AlignmentGeometry alignment;

  /// The text direction with which to resolve [alignment].
  final TextDirection? textDirection;

  /// How to size the non-positioned children in the stack.
  final StackFit sizing;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late List<bool> _activated;

  @override
  void initState() {
    super.initState();
    _activated = List<bool>.filled(widget.children.length, false);
    _activate(widget.index);
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != _activated.length) {
      // If the number of children changes, we try to preserve the state of the
      // existing children.
      final newActivated = List<bool>.filled(widget.children.length, false);
      for (int i = 0; i < newActivated.length && i < _activated.length; i++) {
        newActivated[i] = _activated[i];
      }
      _activated = newActivated;
    }
    _activate(widget.index);
  }

  void _activate(int index) {
    if (index >= 0 && index < _activated.length) {
      if (!_activated[index]) {
        setState(() {
          _activated[index] = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      children: List.generate(widget.children.length, (i) {
        return _activated[i] ? widget.children[i] : const SizedBox.shrink();
      }),
    );
  }
}
