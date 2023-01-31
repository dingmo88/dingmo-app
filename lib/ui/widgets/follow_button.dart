import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_follow.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/colors.dart';
import 'suggest_login_dialog.dart';

class FollowButton extends StatefulWidget {
  final int profileId;
  final bool initIsFollow;
  final Color? backgroundColor;
  const FollowButton(
      {Key? key,
      required this.profileId,
      required this.initIsFollow,
      this.backgroundColor})
      : super(key: key);

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late bool _isFollow;

  @override
  void initState() {
    super.initState();

    _isFollow = widget.initIsFollow;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color?>(!_isFollow
                ? Colors.white
                : widget.backgroundColor ?? AppColors.greyWhite),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(
                        color: !_isFollow
                            ? AppColors.mediumPink
                            : AppColors.greyWhite)))),
        onPressed: () async {
          if (getIt<MemberInfo>().isGuest()) {
            showSuggestLoginDialog(context);
          } else {
            _switchFollow();
            if (!await _follow()) {
              _switchFollow();
              Fluttertoast.showToast(msg: "문제가 발생하였습니다");
            }
          }
        },
        child: Row(
          children: [
            !_isFollow
                ? Text(
                    "+",
                    style: TextStyle(
                        fontSize: 13,
                        color: !_isFollow
                            ? AppColors.mediumPink
                            : AppColors.purpleGrey),
                  )
                : SvgPicture.asset("assets/profile/check_icon.svg"),
            const SizedBox(width: 5),
            Text(
              "관심업체",
              style: TextStyle(
                  fontSize: 13,
                  color:
                      !_isFollow ? AppColors.mediumPink : AppColors.purpleGrey),
            )
          ],
        ));
  }

  Future<bool> _follow() async {
    try {
      await getIt<ApiFollow>().submit(
          PostFollowRequest(atProfileId: widget.profileId, enabled: _isFollow));
      return true;
    } catch (e) {
      safePrint("exception: $e");
    }

    return false;
  }

  void _switchFollow() {
    setState(() {
      _isFollow = !_isFollow;
    });
  }
}
