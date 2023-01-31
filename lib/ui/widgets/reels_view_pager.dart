import 'dart:async';

import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/utils/reels_paging_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart' hide PageView;

final PageController _defaultPageController = PageController();
const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

class ReelsViewPager extends StatefulWidget {
  final int extents;

  final Axis scrollDirection;

  final bool reverse;

  final PageController controller;

  final ScrollPhysics physics;

  final bool pageSnapping;

  final ValueChanged<int> onPageChanged;

  final SliverChildDelegate childrenDelegate;

  final DragStartBehavior dragStartBehavior;

  ReelsViewPager({
    Key? key,
    this.extents = 1,
    this.scrollDirection = Axis.horizontal,
    this.reverse = false,
    PageController? controller,
    required this.physics,
    this.pageSnapping = true,
    required this.onPageChanged,
    required IndexedWidgetBuilder itemBuilder,
    this.dragStartBehavior = DragStartBehavior.start,
  })  : controller = controller ?? _defaultPageController,
        childrenDelegate = SliverChildBuilderDelegate(
          itemBuilder,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
        ),
        super(key: key);

  @override
  ReelsViewPagerState createState() => ReelsViewPagerState();
}

class ReelsViewPagerState extends State<ReelsViewPager> {
  int _lastReportedPage = 0;
  bool _isLockedPageSwipe = true;
  late final StreamSubscription<bool> pageSwipeListen;

  @override
  void initState() {
    super.initState();
    _lastReportedPage = widget.controller.initialPage;
    pageSwipeListen =
        getIt<ReelsPagingManager>().pageSwipeable.listen((isSwipeable) {
      if (mounted) {
        setState(() => _isLockedPageSwipe = !isSwipeable);
      }
    });
  }

  AxisDirection _getDirection(BuildContext context) {
    switch (widget.scrollDirection) {
      case Axis.horizontal:
        assert(debugCheckHasDirectionality(context));
        final TextDirection textDirection = Directionality.of(context);
        final AxisDirection axisDirection =
            textDirectionToAxisDirection(textDirection);
        return widget.reverse
            ? flipAxisDirection(axisDirection)
            : axisDirection;
      case Axis.vertical:
        return widget.reverse ? AxisDirection.up : AxisDirection.down;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    final ScrollPhysics physics = widget.pageSnapping
        ? _kPagePhysics.applyTo(widget.physics)
        : widget.physics;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.depth == 0 &&
            notification is ScrollUpdateNotification) {
          final PageMetrics metrics = notification.metrics as PageMetrics;
          final int currentPage = metrics.page?.round() ?? 0;
          if (currentPage != _lastReportedPage) {
            _lastReportedPage = currentPage;
            widget.onPageChanged(currentPage);
          }
        }
        return false;
      },
      child: IgnorePointer(
          ignoring: _isLockedPageSwipe,
          child: Scrollable(
            dragStartBehavior: widget.dragStartBehavior,
            axisDirection: axisDirection,
            controller: widget.controller,
            physics: physics,
            viewportBuilder: (BuildContext context, ViewportOffset position) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  assert(constraints.hasBoundedHeight);
                  assert(constraints.hasBoundedWidth);

                  double cacheExtent;

                  switch (widget.scrollDirection) {
                    case Axis.vertical:
                      cacheExtent = constraints.maxHeight * widget.extents;
                      break;

                    case Axis.horizontal:
                    default:
                      cacheExtent = constraints.maxWidth * widget.extents;
                      break;
                  }

                  return Viewport(
                    cacheExtent: cacheExtent,
                    axisDirection: axisDirection,
                    offset: position,
                    slivers: <Widget>[
                      SliverFillViewport(
                        viewportFraction: widget.controller.viewportFraction,
                        delegate: widget.childrenDelegate,
                      ),
                    ],
                  );
                },
              );
            },
          )),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await pageSwipeListen.cancel();
  }
}
