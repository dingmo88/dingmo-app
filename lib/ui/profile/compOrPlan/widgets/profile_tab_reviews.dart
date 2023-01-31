import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/profile/compOrPlan/widgets/review_write_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants/colors.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/texts.dart';
import '../items/comp_profile_item.dart';
import 'review_item.dart';

class ProfileTabReviews extends StatefulWidget {
  final List<ReviewItem> reviews;
  final bool isLastReviewsLoaded;
  const ProfileTabReviews(
      {Key? key, required this.reviews, required this.isLastReviewsLoaded})
      : super(key: key);

  @override
  State<ProfileTabReviews> createState() => _ProfileTabReviewsState();
}

class _ProfileTabReviewsState extends State<ProfileTabReviews> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
            maintainState: true,
            visible: widget.reviews.isNotEmpty,
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              child: Column(
                children: [
                  Visibility(
                      visible:
                          getIt<MemberInfo>().memberType == MemberType.user,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            width: 108,
                            margin: const EdgeInsets.only(
                                top: 15, bottom: 10, right: 20),
                            child: ReviewWriteButton(
                              onWrittenReview: (reviewItem) {},
                            )),
                      )),
                  ...(widget.reviews
                      .map((review) => ReviewItemWidget(
                            type: ReviewItemType.inList,
                            item: review,
                          ))
                      .toList()),
                  Visibility(
                      visible: !widget.isLastReviewsLoaded,
                      child: const DingmoProgressIndicator(
                          size: 40,
                          margin: EdgeInsets.symmetric(vertical: 20))),
                  Visibility(
                      visible: widget.isLastReviewsLoaded,
                      child: const SizedBox(
                        height: 40,
                      )),
                ],
              ),
            )),
        Visibility(
            maintainState: true,
            visible: widget.reviews.isEmpty,
            child: noContentWidget())
      ],
    );
  }

  Widget noContentWidget() {
    return Center(
      child: Column(
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
      ),
    );
  }
}
