import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "서비스 이용 약관"),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          termsOfUseText,
          style: TextStyle(
              fontSize: 14, color: AppColors.greyishBrown, height: 1.5),
        ),
      )),
    );
  }

  final String termsOfUseText = '''제2조 (용어의 정의)
1. '서비스'라 함은 이용매체(PC, 이동통신단말장치)와 상관없이 '회원'이 이용할 수 있는 모든 '아이엠스쿨'의 서비스를 의미합니다.

2. ’콘텐츠’란 문장, 음성, 음악, 이미지, 동영상, 기타정보 등을 의미합니다.

3. ‘사이트’란 '회사'가 콘텐츠, 상품 등 서비스를 '이용자'에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 설정한 가상의 영업장을 의미합니다.

4. ’회원’이라 함은 '사이트'에 회원등록 한 자로서, 계속적으로 '사이트'에서 제공하는 모든 서비스를 이용할 수 있는 자를 말합니다.

5. ‘비회원’이라 함은 회원에 가입하지 않고 회사가 제공하는 서비스를 이용하는 자를 말합니다.

6. '이용자'라 함은 '회원' 및 ‘비회원’을 포함한 '서비스'의 모든 이용자를 의미합니다.

7. '상품'이라 함은 '회사'가 '이용자'에게 판매를 대행하는 제3자의 유형/무형 상품을 의미합니다.

8. '개별 이용약관'이란 본 서비스에 관해 본 약관과는 별도로 '가이드라인', '정책' 등의 명칭으로 당사가 배포 또는 게시한 문서를 말합니다.

9. '게시물'이라 함은 '회원'이 '서비스'를 이용함에 있어 '서비스'상에 게시한 부호_문자_음성_음향_화상_동영상 등의 정보 형태의 글, 사진, 동영상 및 각종 파일과 링크 등을 의미합니다.
''';
}
