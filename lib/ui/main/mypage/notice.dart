import 'package:dingmo/ui/main/mypage/items/notice_item.dart';
import 'package:dingmo/ui/main/mypage/widgets/notice_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "공지사항"),
      body: ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: InfinityListWidget<NoticeItem>(
            initLoadingBuilder: (context) => Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 20),
                child: const DingmoProgressIndicator(size: 40)),
            pageSize: 5,
            onLoad: getNotices,
            header: const SizedBox(height: 25),
            itemBuilder: (context, item, index) => NoticeItemWidget(item: item),
          )),
    );
  }

  Future<List<NoticeItem>> getNotices(int startIdx, int pageSize) {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<NoticeItem> notices = [];

      for (int idx = startIdx; idx < startIdx + pageSize; idx++) {
        if (idx % 2 == 0) {
          notices.add(NoticeItem(
              title: "2.0 버전 업데이트 안내",
              content: '''안녕하십니까, 딩모입니다.
원활한 이용을 위한 업데이트 내용을 안내해드립니다.

※일자
- 2022.01.12 (수)

※버전
- Eyesurfer Ver 4.2.26

※업데이트 내용
◆[기능개선/추가]
- 기사검색 키워드 리스트 전체 삭제 추가
- 템플릿 자동화 기능 안내팝업 노출

◆[오류수정]
- 편집출력 기사 이동시 이미지 잔상 남는 현상 수정
- 환경설정 관심키워드 구분자 오류 수정

항상 최선을 다하는 딩모가 되겠습니다.''',
              dateCreated: "2022.04.23"));
        } else {
          notices.add(NoticeItem(
              title: "이용약관 변경 안내",
              content: '''안녕하십니까, 딩모입니다.
원활한 이용을 위한 업데이트 내용을 안내해드립니다.

※일자
- 2022.01.12 (수)

※버전
- Eyesurfer Ver 4.2.26

※업데이트 내용
◆[기능개선/추가]
- 기사검색 키워드 리스트 전체 삭제 추가
- 템플릿 자동화 기능 안내팝업 노출

◆[오류수정]
- 편집출력 기사 이동시 이미지 잔상 남는 현상 수정
- 환경설정 관심키워드 구분자 오류 수정

항상 최선을 다하는 딩모가 되겠습니다.''',
              dateCreated: "2022.04.23"));
        }
      }

      return notices;
    });
  }
}
