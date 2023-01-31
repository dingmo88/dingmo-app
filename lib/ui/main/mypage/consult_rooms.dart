import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/items/consult_room_item.dart';
import 'package:dingmo/ui/main/mypage/widgets/consult_room_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';

class ConsultRoomsPage extends StatefulWidget {
  const ConsultRoomsPage({Key? key}) : super(key: key);

  @override
  State<ConsultRoomsPage> createState() => _ConsultRoomsPageState();
}

class _ConsultRoomsPageState extends State<ConsultRoomsPage> {
  late final Future<List<ConsultRoomItem>> getConsultRoomsFuture;

  @override
  void initState() {
    super.initState();

    getConsultRoomsFuture = getConsultRooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.defaultAppBar(context, title: "상담 내역"),
        body: FutureBuilder<List<ConsultRoomItem>>(
            future: getConsultRoomsFuture,
            builder: (BuildContext context,
                AsyncSnapshot<List<ConsultRoomItem>> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.mediumPink,
                  ),
                );
              } else {
                final List<ConsultRoomItem> consultRoomList = snapshot.data!;
                return ListView.builder(
                  itemCount: consultRoomList.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ConsultRoomItemWidget(
                          item: consultRoomList[index],
                          onRoomExited: () {
                            setState(() => consultRoomList.removeAt(index));
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: AppColors.mediumPink,
                                content: Text(
                                  "[${consultRoomList[index].nickname}] 채팅방 삭제되었습니다.",
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.white),
                                )));
                          }),
                );
              }
            }));
  }

  Future<List<ConsultRoomItem>> getConsultRooms() {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<ConsultRoomItem> consultRooms = [];

      for (int idx = 0; idx < 5; idx++) {
        consultRooms.add(ConsultRoomItem(
            profileUrl: "https://picsum.photos/id/${277}/100/100",
            nickname: "woori_wedding${idx + 1}",
            lastMessage: "저번에 알려주신 그 웨딩드레스는 사이가 너무 폭이 넓어서요",
            dateLastSent: "방금 전",
            hasNewMessage: idx == 0 || idx == 1));
      }

      return consultRooms;
    });
  }
}
