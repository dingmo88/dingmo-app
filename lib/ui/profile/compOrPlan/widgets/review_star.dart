import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewStarWidget extends StatefulWidget {
  final void Function(int starCount) onStarChanged;
  const ReviewStarWidget({Key? key, required this.onStarChanged})
      : super(key: key);

  @override
  State<ReviewStarWidget> createState() => _ReviewStarWidgetState();
}

class _ReviewStarWidgetState extends State<ReviewStarWidget> {
  int maxStarCount = 5;
  int currentStar = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [1, 2, 3, 4, 5].map((pos) => starButton(pos)).toList());
  }

  Widget starButton(int starPos) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentStar = starPos;
        });
        widget.onStarChanged(starPos);
      },
      child: Container(
          margin: const EdgeInsets.only(right: 10),
          color: Colors.transparent,
          child: isOn(starPos)
              ? SvgPicture.asset("assets/home/star_icon_on.svg")
              : SvgPicture.asset("assets/home/star_icon_off.svg")),
    );
  }

  bool isOn(int starPos) {
    return starPos <= currentStar;
  }
}
