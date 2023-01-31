import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyPageMenu extends StatelessWidget {
  final String name;
  final VoidFunc onPressed;
  const MyPageMenu({Key? key, required this.name, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 14,
                color: AppColors.greyishBrown,
                fontWeight: FontWeight.w500),
          ),
          SvgPicture.asset("assets/mypage/right_icon.svg")
        ]),
      ),
    );
  }
}
