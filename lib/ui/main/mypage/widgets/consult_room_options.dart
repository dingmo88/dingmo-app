import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/texts.dart';
import 'cosult_room_exit_check.dart';

class ConsultRoomOptionsWidget extends StatelessWidget {
  final String nickname;
  final void Function() onRoomExited;

  const ConsultRoomOptionsWidget({
    Key? key,
    required this.nickname,
    required this.onRoomExited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.25,
      initialChildSize: 0.25,
      maxChildSize: 0.25,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Texts.defaultText(
                      text: "채팅 목록", fontSize: 16, fontWeight: FontWeight.bold),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                    iconSize: 20,
                  )
                ],
              ),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "[$nickname] 님",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.greyishBrown),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          showExitRoomAlertDialog(context, () {
                            Navigator.pop(context);
                            onRoomExited();
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          color: Colors.transparent,
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "채팅방 나가기",
                            style: TextStyle(
                                fontSize: 14, color: AppColors.greyishBrown),
                          ),
                        ))
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void showExitRoomAlertDialog(BuildContext context, void Function() onExit) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CheckExitRoomDialog(nickname: nickname, onExit: onExit);
        });
  }
}
