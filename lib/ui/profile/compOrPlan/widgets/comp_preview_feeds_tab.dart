import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants/colors.dart';
import '../../../widgets/texts.dart';

class CompEditPreviewFeedsTab extends StatefulWidget {
  const CompEditPreviewFeedsTab({Key? key}) : super(key: key);

  @override
  State<CompEditPreviewFeedsTab> createState() =>
      _CompEditPreviewFeedsTabState();
}

class _CompEditPreviewFeedsTabState extends State<CompEditPreviewFeedsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 65),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.greyWhite,
              borderRadius: BorderRadius.circular(99)),
          child: SvgPicture.asset("assets/profile/camera_icon.svg"),
        ),
        const SizedBox(height: 15),
        Texts.defaultText(
            text: "아직 게시물이 없어요", fontSize: 12, color: AppColors.veryLightPink)
      ],
    );
  }
}
