import 'package:dingmo/ui/profile/compOrPlan/items/alarm_item.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/alarm_item2.dart';
import 'package:dingmo/ui/profile/compOrPlan/widgets/alarm_item1.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';

import 'widgets/alarm_item2.dart';

class CompAlarmsPage extends StatefulWidget {
  const CompAlarmsPage({Key? key}) : super(key: key);

  @override
  State<CompAlarmsPage> createState() => _CompAlarmsPageState();
}

class _CompAlarmsPageState extends State<CompAlarmsPage> {
  final List<AlarmItem1> alarmList = [];
  final List<AlarmItem2> pastAlarmList = [];
  late final Future<void> getAlarmListFuture;

  @override
  void initState() {
    super.initState();
    getAlarmListFuture = getAlarmList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "알림"),
      body: FutureBuilder<void>(
        future: getAlarmList(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.only(top: 60),
              child: const DingmoProgressIndicator(size: 40),
            );
          } else {
            return ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: InfinityListWidget<AlarmItem2>(
                  pageSize: 10,
                  header: Column(children: [
                    AlarmItem1Widget(item: alarmList[0]),
                    AlarmItem1Widget(item: alarmList[1])
                  ]),
                  itemBuilder: (context, item, index) =>
                      AlarmItem2Widget(item: item),
                  onLoad: getPastAlarmList,
                ));
          }
        },
      ),
    );
  }

  Future<void> getAlarmList() {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<AlarmItem2> todayAlarms = [];
      final List<AlarmItem2> pastAlarms = [];

      todayAlarms.add(AlarmItem2(
          title: "첫 게시물 포인트 지급 🔆",
          content: "딩모숏에 첫 게시물을 등록하여 1000P를 드립니다!",
          dateOld: "방금 전"));
      todayAlarms.add(AlarmItem2(
          title: "좋아요 알림💕",
          content: "김아라님, bomi 님 외 13명이 회원님의 게시물을 좋아합니다",
          dateOld: "10분 전"));
      todayAlarms.add(AlarmItem2(
          title: "좋아요 알림💕",
          content: "김아라님이 회원님의 게시물을 좋아합니다",
          dateOld: "10분 전"));
      todayAlarms.add(AlarmItem2(
          title: "좋아요 알림💕",
          content: "김아라님이 댓글을 남겼습니다: 신부님 웨딩드레스 너무 예뻐요!! 가격 정보를 알고싶은데 비댓으로 남겨요",
          dateOld: "10분 전"));

      for (int idx = 0; idx < 10; idx++) {
        pastAlarms.add(AlarmItem2(
            title: "댓글 등록 알림👀",
            content:
                "김아라님이 댓글을 남겼습니다: 신부님 웨딩드레스 너무 예뻐요!! 가격 정보를 알고싶은데 비댓으로 남겨요",
            dateOld: "2일 전"));
      }

      alarmList.add(AlarmItem1(dateTitle: "오늘", items: todayAlarms));
      alarmList.add(AlarmItem1(dateTitle: "지난 알림", items: pastAlarms));
    });
  }

  Future<List<AlarmItem2>> getPastAlarmList(int idx, int pageSize) {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<AlarmItem2> pastAlarms = [];

      for (int idx = 0; idx < 10; idx++) {
        pastAlarms.add(AlarmItem2(
            title: "댓글 등록 알림👀",
            content:
                "김아라님이 댓글을 남겼습니다: 신부님 웨딩드레스 너무 예뻐요!! 가격 정보를 알고싶은데 비댓으로 남겨요",
            dateOld: "2일 전"));
      }

      return pastAlarms;
    });
  }
}
