import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_like.dart';
import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/suggest_login_dialog.dart';
import '../../../widgets/texts.dart';

class ReelsLikeButton extends StatefulWidget {
  final GetShortsResult data;
  final Future<void> Function() onLoginSuggestStarted;
  final Future<void> Function() onLoginSuggestEnded;
  const ReelsLikeButton(
      {Key? key,
      required this.data,
      required this.onLoginSuggestStarted,
      required this.onLoginSuggestEnded})
      : super(key: key);

  @override
  State<ReelsLikeButton> createState() => _ReelsLikeButtonState();
}

class _ReelsLikeButtonState extends State<ReelsLikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (getIt<MemberInfo>().isGuest()) {
            showSuggestLoginDialog();
            return;
          }

          switchLike();
          if (!await like()) {
            switchLike();
            Fluttertoast.showToast(msg: "문제가 발생하였습니다");
          }
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(99),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 50.0,
                        spreadRadius: 20.0,
                      )
                    ],
                  ),
                  child: SvgPicture.asset(
                    widget.data.isLike
                        ? "assets/home/like_on_reels_icon.svg"
                        : "assets/home/like_off_reels_icon.svg",
                  )),
              const SizedBox(height: 5),
              Texts.defaultText(
                  text: widget.data.likeCnt.toString(),
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ],
          ),
        ));
  }

  void switchLike() {
    setState(() {
      widget.data.isLike = !widget.data.isLike;
      widget.data.likeCnt += widget.data.isLike ? 1 : -1;
    });
  }

  Future<bool> like() async {
    try {
      await getIt<ApiLike>().submit(PostLikeRequest(
          likeType: likeTypeToValue(LikeType.content),
          atId: widget.data.contentId,
          isLike: widget.data.isLike));

      return true;
    } catch (e) {
      safePrint("exception: $e");
    }

    return false;
  }

  void showSuggestLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => SuggestLoginDialog(
              onYes: widget.onLoginSuggestStarted,
              onFinished: widget.onLoginSuggestEnded,
            ));
  }
}
