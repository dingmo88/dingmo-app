import 'package:flutter/material.dart';

class FadeOnScroll extends StatefulWidget {
  final ScrollController scrollController;
  final double zeroOpacityOffset;
  final double fullOpacityOffset;
  final Widget child;

  const FadeOnScroll(
      {Key? key,
      required this.scrollController,
      required this.child,
      this.zeroOpacityOffset = 0,
      this.fullOpacityOffset = 0})
      : super(key: key);

  @override
  FadeOnScrollState createState() => FadeOnScrollState();
}

class FadeOnScrollState extends State<FadeOnScroll> {
  late double offset;

  @override
  initState() {
    super.initState();
    offset = widget.scrollController.offset;
    widget.scrollController.addListener(_setOffset);
  }

  @override
  dispose() {
    widget.scrollController.removeListener(_setOffset);
    super.dispose();
  }

  void _setOffset() {
    setState(() {
      offset = widget.scrollController.offset;
    });
  }

  double _calculateOpacity() {
    if (widget.fullOpacityOffset == widget.zeroOpacityOffset) {
      return 1;
    } else if (widget.fullOpacityOffset > widget.zeroOpacityOffset) {
      // fading in
      if (offset <= widget.zeroOpacityOffset) {
        return 0;
      } else if (offset >= widget.fullOpacityOffset) {
        return 1;
      } else {
        return (offset - widget.zeroOpacityOffset) /
            (widget.fullOpacityOffset - widget.zeroOpacityOffset);
      }
    } else {
      // fading out
      if (offset <= widget.fullOpacityOffset) {
        return 1;
      } else if (offset >= widget.zeroOpacityOffset) {
        return 0;
      } else {
        return (offset - widget.fullOpacityOffset) /
            (widget.zeroOpacityOffset - widget.fullOpacityOffset);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _calculateOpacity(),
      child: widget.child,
    );
  }
}
