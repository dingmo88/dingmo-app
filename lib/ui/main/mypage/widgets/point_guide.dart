import 'package:dingmo/ui/widgets/description_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/colors.dart';

class PointGuideDialog extends StatelessWidget {
  const PointGuideDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.topRight,
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset("assets/mypage/close_icon.svg"),
                ),
              ),
              Text(
                "포인트 안내",
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.greyishBrown,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              DescriptionText(
                  description: "포인트는 딩모 회원만 사용이 가능합니다. 스토어를 준비중이니 조금만 기다려주세요🙌",
                  color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              DescriptionText(
                  description: "딩모 회원을 탈퇴할 경우, 잔여 포인트는 모두 소멸됩니다.",
                  color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              DescriptionText(
                  description: "포인트 정책은 딩모 운영 정책에 따라 변경될 수 있습니다.",
                  color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              DescriptionText(
                  description: "하루 최대 얻을 수 있는 포인트는 1,000P 입니다.",
                  color: AppColors.purpleGrey),
              const SizedBox(height: 30),
              Text(
                "Q. 포인트 얻는 방법",
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.greyishBrown,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 15),
              DescriptionText(
                  description: "사진 게시물, 딩모숏 게시물 업로드시",
                  color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              DescriptionText(
                  description: "댓글(최소 5글자 이상, 중복댓글 제외)",
                  color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              DescriptionText(
                  description: "딩모숏 재생시", color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              DescriptionText(
                  description: "업체 후기 등록", color: AppColors.purpleGrey),
              const SizedBox(height: 15),
            ],
          )),
    );
  }
}
