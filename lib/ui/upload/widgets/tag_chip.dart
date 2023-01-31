import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/colors.dart';
import '../../widgets/texts.dart';

class TagChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidFunc onPressed;
  const TagChip(
      {Key? key,
      required this.text,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        backgroundColor: Colors.white,
        shape: StadiumBorder(
            side: BorderSide(
                color: isSelected ? AppColors.mediumPink : AppColors.greyWhite,
                width: 1.5)),
        label: Texts.defaultText(text: text, fontSize: 13),
      ),
    );
  }
}

class CustomTagChip extends StatelessWidget {
  final String text;
  final VoidFunc onDelete;
  const CustomTagChip({Key? key, required this.text, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      onDeleted: onDelete,
      deleteIcon:
          SvgPicture.asset("assets/home/make_contents/tag_delete_icon.svg"),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      backgroundColor: AppColors.greyWhite,
      label: Texts.defaultText(text: "#$text", fontSize: 13),
    );
  }
}
