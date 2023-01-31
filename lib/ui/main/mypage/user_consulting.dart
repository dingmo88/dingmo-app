import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/widgets/consult_ment_forms.dart';
import 'package:flutter/material.dart';

import '../../widgets/texts.dart';
import '../../widgets/user_message_form_panel.dart';
import 'widgets/consulting_messages.dart';

class UserConsultingPage extends StatefulWidget {
  const UserConsultingPage({Key? key}) : super(key: key);

  @override
  State<UserConsultingPage> createState() => _UserConsultingPageState();
}

class _UserConsultingPageState extends State<UserConsultingPage> {
  List<String> messages = ["1", "2", "3", "4", "5", "6", "7"];

  final ScrollController messageController = ScrollController();

  @override
  void initState() {
    super.initState();

    messages.add("23일에 방문 가능한가요?");
    messages.add(
        "지금은 상담 시간이 아닙니다. 궁금한 질문사항을 남겨주시면 상담 가능 시간에 확인 후 순차적으로 답변 도와드리겠습니다:)\n\n⏰상담시간: 매일 오전 10시~오후7시");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mediumPink,
        title: Row(children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: AppColors.greyWhite)),
              width: 28,
              height: 28,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                    imageUrl: "https://picsum.photos/id/247/105/105",
                    fit: BoxFit.cover,
                    errorWidget: (context, exception, stackTrace) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/dingmo.png",
                        ),
                      );
                    }),
              )),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Texts.defaultText(
                  color: Colors.white,
                  text: "woori_wedding",
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              Texts.defaultText(
                color: Colors.white,
                text: "예비신랑신부",
                fontSize: 12,
              )
            ],
          )
        ]),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: AppColors.lightPink,
      body: UserMessageFormPanel(
        contentWidget: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              controller: messageController,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                Widget widget;

                if (index == 0) {
                  widget = const PhoneVerifyFormWidget();
                } else if (index == 1) {
                  widget = answer1();
                } else if (index == 2) {
                  widget = const WeddingDateFormWidget();
                } else if (index == 3) {
                  widget = answer2();
                } else if (index == 4) {
                  widget = const WeddingAreaFormWidget();
                } else if (index == 5) {
                  widget = answer3();
                } else if (index == 6) {
                  widget = Text(
                    "응답해주셔서 감사합니다☺️ 궁금 질문사항을 남겨주시면 상담 가능 시간에 확인 후 순차적으로 답변 도와드리겠습니다:)",
                    style:
                        TextStyle(fontSize: 13, color: AppColors.greyishBrown),
                  );
                } else {
                  widget = Text(
                    messages[index],
                    style:
                        TextStyle(fontSize: 13, color: AppColors.greyishBrown),
                  );
                }

                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index >= messages.length - 1 ? 100 : 0),
                  child: index % 2 != 0
                      ? MyMessage(
                          dateSent: "오전 07:50",
                          child: widget,
                        )
                      : YourMessage(
                          dateSent: "오후 11:12",
                          child: widget,
                        ),
                );
              },
            )),
        onCompleteWriteMessage: (String message) {
          setState(() {
            messages.add(message);
            Future.delayed(const Duration(milliseconds: 10), () {
              messageController.animateTo(
                  messageController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.ease);
            });
          });
        },
        onSelectedMent: (String ment) {
          setState(() {
            messages.add(ment);
            Future.delayed(const Duration(milliseconds: 10), () {
              messageController.animateTo(
                  messageController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.ease);
            }).then((_) {
              Future.delayed(const Duration(milliseconds: 200), () {
                setState(() {
                  messages.add(
                      "지금은 상담 시간이 아닙니다. 궁금한 질문사항을 남겨주시면 상담 가능 시간에 확인 후 순차적으로 답변 도와드리겠습니다:)\n\n⏰상담시간: 매일 오전 10시~오후7시");

                  Future.delayed(const Duration(milliseconds: 10), () {
                    messageController.animateTo(
                        messageController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.ease);
                  });
                });
              });
            });
          });
        },
        ments: const ["상담시간은 언제인가요?"],
      ),
    );
  }

  Widget answer1() {
    return Text(
      "본인 인증 완료",
      style: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
    );
  }

  Widget answer2() {
    return Text(
      "2023년5월18일",
      style: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
    );
  }

  Widget answer3() {
    return Text(
      "강동구/강진구/송파구",
      style: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
    );
  }
}
