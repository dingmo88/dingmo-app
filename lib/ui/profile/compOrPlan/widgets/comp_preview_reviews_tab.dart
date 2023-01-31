import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants/colors.dart';
import '../../../widgets/texts.dart';

class CompEditPreviewReviewsTab extends StatefulWidget {
  const CompEditPreviewReviewsTab({Key? key}) : super(key: key);

  @override
  State<CompEditPreviewReviewsTab> createState() =>
      _CompEditPreviewReviewsTabState();
}

class _CompEditPreviewReviewsTabState extends State<CompEditPreviewReviewsTab> {
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
          child: SvgPicture.asset("assets/profile/non_review_icon.svg"),
        ),
        const SizedBox(height: 15),
        Texts.defaultText(
            text: "아직 후기가 없어요", fontSize: 12, color: AppColors.veryLightPink)
      ],
    );
  }
}
