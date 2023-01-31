import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContentUploadButton extends StatefulWidget {
  final bool isDarkMode;
  final void Function() onPress;
  const ContentUploadButton(
      {Key? key, required this.isDarkMode, required this.onPress})
      : super(key: key);

  @override
  State<ContentUploadButton> createState() => _ContentUploadButtonState();
}

class _ContentUploadButtonState extends State<ContentUploadButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 30, top: 10),
        alignment: Alignment.center,
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(99),
          color: widget.isDarkMode ? Colors.white : AppColors.mediumPink,
        ),
        child: InkWell(
          onTap: widget.onPress,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: widget.isDarkMode
                ? SvgPicture.asset(
                    "assets/bottom_navi/dark_mode/plus_icon.svg",
                  )
                : SvgPicture.asset(
                    "assets/bottom_navi/light_mode/plus_icon.svg",
                  ),
          ),
        ));
  }
}
