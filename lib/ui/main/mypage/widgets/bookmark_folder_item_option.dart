import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BookmarkFolderItemOptionButton extends StatelessWidget {
  final String assetUrl;
  final String name;
  final void Function() onPressed;
  const BookmarkFolderItemOptionButton({
    Key? key,
    required this.assetUrl,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        child: Column(children: [
          SvgPicture.asset(assetUrl),
          const SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
          ),
        ]),
      ),
    );
  }
}
