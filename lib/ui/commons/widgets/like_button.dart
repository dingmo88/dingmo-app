import 'package:dingmo/ui/widgets/comment_item.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants/colors.dart';

class ReplyTargetLikeButton extends StatefulWidget {
  final CommentItem commentItem;
  final void Function(bool value) onLikeSwitched;
  final void Function(int likeCount) onLikeCountChanged;
  const ReplyTargetLikeButton({
    Key? key,
    required this.commentItem,
    required this.onLikeSwitched,
    required this.onLikeCountChanged,
  }) : super(key: key);

  @override
  State<ReplyTargetLikeButton> createState() => _ReplyTargetLikeButtonState();
}

class _ReplyTargetLikeButtonState extends State<ReplyTargetLikeButton> {
  late bool isLiked;
  late int likeCount;

  @override
  void initState() {
    super.initState();

    isLiked = widget.commentItem.isLiked;
    likeCount = widget.commentItem.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isLiked = !isLiked;
            likeCount = isLiked ? likeCount + 1 : likeCount - 1;
            widget.onLikeSwitched(isLiked);
            widget.onLikeCountChanged(likeCount);
          });
        },
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          color: Colors.transparent,
          child: Row(
            children: [
              isLiked
                  ? SvgPicture.asset("assets/home/like_on_comment_icon.svg")
                  : SvgPicture.asset(
                      "assets/home/like_off_comment_icon.svg",
                      color: AppColors.purpleGrey,
                    ),
              const SizedBox(width: 5),
              Texts.defaultText(
                  text: likeCount.toString(),
                  fontSize: 12,
                  color: isLiked ? AppColors.mediumPink : AppColors.purpleGrey),
            ],
          ),
        ));
  }
}
