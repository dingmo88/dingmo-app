import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/texts.dart';

class SearchTagChip extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const SearchTagChip({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Chip(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          backgroundColor: Colors.white,
          shape: StadiumBorder(
              side: BorderSide(color: AppColors.greyWhite, width: 1.5)),
          label: Texts.defaultText(text: text, fontSize: 13)),
    );
  }
}
