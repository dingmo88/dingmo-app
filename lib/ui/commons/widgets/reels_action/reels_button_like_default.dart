import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReelsLikeButtonDefault extends StatefulWidget {
  const ReelsLikeButtonDefault({Key? key}) : super(key: key);

  @override
  State<ReelsLikeButtonDefault> createState() => _ReelsLikeButtonDefaultState();
}

class _ReelsLikeButtonDefaultState extends State<ReelsLikeButtonDefault> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 50.0,
              spreadRadius: 20.0,
            )
          ],
        ),
        child: SvgPicture.asset(
          "assets/home/like_off_reels_icon.svg",
        ));
  }
}
