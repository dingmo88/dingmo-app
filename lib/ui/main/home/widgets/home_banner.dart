import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;

import '../../../widgets/page_indicator.dart';

class SliverHomeBannerDelegate extends SliverPersistentHeaderDelegate {
  final List<String> bannImgKeys;
  int selectedIndex = 0;
  late final double radius;
  late final double radiusHeight;
  late final double maxHeight;
  late final double minHeight;

  late final double startPx;
  late final double endPx;
  late final double startPxRatio;
  late final double endPxRatio;
  late final double gapOfPoints;

  SliverHomeBannerDelegate({required this.bannImgKeys}) {
    radius = 20.0;
    radiusHeight = 25.0;
    maxHeight = 244.0 + radiusHeight;
    minHeight = 0.0;
    startPx = 125;
    endPx = 50;
    startPxRatio = startPx / maxHeight;
    endPxRatio = endPx / maxHeight;
    gapOfPoints = (startPxRatio - endPxRatio).abs();
  }

  double scrollAnimationValue(double shrinkOffset) {
    double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  double radiusByAnimationVal(double animationVal) {
    if (animationVal > startPxRatio) {
      return radius;
    } else {
      final decreasedValFromMaxPoint = animationVal - startPxRatio;
      final progress = progressFunc(decreasedValFromMaxPoint);
      final radiusDecreaseVal = radius * progress;
      final newRadius = radius - radiusDecreaseVal;

      return newRadius <= 0.0 ? 0.0 : newRadius;
    }
  }

  double progressFunc(double x) {
    return -(1 / gapOfPoints) * x;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);
    return SizedBox(
      height: visibleMainHeight,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(color: AppColors.veryLightPink),
          Container(
            decoration: BoxDecoration(
                color: AppColors.veryLightPink,
                border: const Border(
                    bottom: BorderSide(color: Colors.white, width: 1))),
            child: _HomeBannerWidget(
              bannImgKeys: bannImgKeys,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: radiusHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(radiusByAnimationVal(animationVal)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 244.0 + 25.0;

  @override
  double get minExtent => 0.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _HomeBannerWidget extends StatefulWidget {
  final List<String> bannImgKeys;
  const _HomeBannerWidget({Key? key, required this.bannImgKeys})
      : super(key: key);

  @override
  State<_HomeBannerWidget> createState() => _HomeBannerWidgetState();
}

class _HomeBannerWidgetState extends State<_HomeBannerWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
            itemCount: widget.bannImgKeys.length,
            pageSnapping: true,
            onPageChanged: (pageIndex) {
              setState(() {
                selectedIndex = pageIndex;
              });
            },
            itemBuilder: (context, pageIndex) {
              return CachedNetworkImage(
                  imageUrl: path.join(
                      Endpoints.imgUrl, widget.bannImgKeys[pageIndex]),
                  fit: BoxFit.cover);
            }),
        Column(
          children: [
            const Spacer(),
            PageIndicator(
              size: 7,
              spacing: 5,
              selectedColor: Colors.white,
              unselectedColor: const Color(0xffdddddd),
              selectedIndex: selectedIndex,
              itemCount: widget.bannImgKeys.length,
            ),
            const SizedBox(height: 45)
          ],
        ),
        Container(
          padding: const EdgeInsets.only(right: 20, top: 50),
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.homeTabEventBannerList),
              child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.center,
                  child: SvgPicture.asset("assets/home/plus_icon.svg"))),
        )
      ],
    );
  }
}
