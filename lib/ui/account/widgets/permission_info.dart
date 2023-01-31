import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PermissionInfoWidget extends StatelessWidget {
  final String assetDir;
  final String title;
  final String description;

  const PermissionInfoWidget(
      {required this.assetDir,
      required this.title,
      required this.description,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(assetDir),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Texts.defaultText(text: title, fontSize: 13),
            const SizedBox(height: 10),
            Texts.defaultText(text: description, fontSize: 13)
          ],
        ),
      ],
    );
  }
}
