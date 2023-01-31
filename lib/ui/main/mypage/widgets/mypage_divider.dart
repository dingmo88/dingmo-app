import 'package:dingmo/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class MyPageDivider extends StatelessWidget {
  final double? height;
  const MyPageDivider({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: height ?? 1,
        color: AppColors.greyWhite);
  }
}
