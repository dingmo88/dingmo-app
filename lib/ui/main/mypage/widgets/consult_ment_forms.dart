import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class PhoneVerifyFormWidget extends StatelessWidget {
  const PhoneVerifyFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "안녕하세요!\n딩모웨딩 웨딩플래너 입니다😀\n1:1 문의 메시지를 이용하려면 상담 품질 관리를 위해 본인 인증이 필요합니다👀",
          style: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: AppColors.mediumPink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Center(
                  child: Text(
                "휴대폰 본인 인증",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
            )),
      ],
    );
  }
}

class WeddingDateFormWidget extends StatelessWidget {
  const WeddingDateFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "인증을 완료해주셔서 감사합니다💕\n예식 정보를 입력해주시면 상담 준비에 큰 도움이 돼요💪",
          style: TextStyle(
              fontSize: 13, color: AppColors.greyishBrown, height: 1.2),
        ),
        const SizedBox(height: 15),
        Text(
          "Q. 예식 날짜가 정해지셨나요?",
          style: TextStyle(
              fontSize: 13,
              color: AppColors.greyishBrown,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: AppColors.mediumPink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Center(
                  child: Text(
                "예식 날짜 입력",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
            )),
        const SizedBox(height: 15),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text(
                "미정입니다",
                style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
              )),
            )),
      ],
    );
  }
}

class WeddingAreaFormWidget extends StatelessWidget {
  const WeddingAreaFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q. 예식 지역이 어디인가요?",
          style: TextStyle(
              fontSize: 13,
              color: AppColors.greyishBrown,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: AppColors.mediumPink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: const Center(
                  child: Text(
                "예식 지역 선택",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )),
            )),
        const SizedBox(height: 15),
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                  child: Text(
                "미정입니다",
                style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
              )),
            )),
      ],
    );
  }
}
