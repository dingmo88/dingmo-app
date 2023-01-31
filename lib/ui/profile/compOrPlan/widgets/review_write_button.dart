import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/review_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReviewWriteButton extends StatelessWidget {
  final void Function(ReviewItem reviewItem) onWrittenReview;
  const ReviewWriteButton({Key? key, required this.onWrittenReview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.only(left: 15)),
          backgroundColor:
              MaterialStateProperty.all<Color?>(AppColors.greyishBrown),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)))),
      onPressed: () {
        Navigator.pushNamed(context, Routes.reviewWrite).then((reviewItem) {
          if (reviewItem != null) {
            onWrittenReview(reviewItem as ReviewItem);
          }
        });
      },
      child: Row(
        children: [
          SvgPicture.asset("assets/profile/floating_edit_icon.svg"),
          const SizedBox(width: 5),
          const Text(
            "후기 올리기",
            style: TextStyle(fontSize: 13, color: Colors.white),
          )
        ],
      ),
    );
  }
}
