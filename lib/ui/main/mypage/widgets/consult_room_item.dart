import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/mypage/items/consult_room_item.dart';
import 'package:flutter/material.dart';

import 'consult_room_options.dart';

class ConsultRoomItemWidget extends StatefulWidget {
  final ConsultRoomItem item;
  final void Function() onRoomExited;
  const ConsultRoomItemWidget(
      {Key? key, required this.item, required this.onRoomExited})
      : super(key: key);

  @override
  State<ConsultRoomItemWidget> createState() => _ConsultRoomItemWidgetState();
}

class _ConsultRoomItemWidgetState extends State<ConsultRoomItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.consulting);
      },
      onLongPress: () {
        showArea1InfoSheet();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: SizedBox(
              width: 40,
              height: 40,
              child: CachedNetworkImage(
                  imageUrl: widget.item.profileUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, exception, stackTrace) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/dingmo.png",
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width - 40 - 40 - 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.item.nickname,
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.greyishBrown,
                            fontWeight: widget.item.hasNewMessage
                                ? FontWeight.bold
                                : FontWeight.w500),
                      ),
                      Text(
                        widget.item.dateLastSent,
                        style: TextStyle(
                            fontSize: 12, color: AppColors.veryLightPink),
                      )
                    ],
                  )),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 40 - 40 - 10,
                child: Row(
                  children: [
                    Visibility(
                        visible: widget.item.hasNewMessage,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                              color: AppColors.mediumPink,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(99))),
                        )),
                    const SizedBox(width: 4),
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 40 - 40 - 60,
                        child: Text(
                          widget.item.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 13,
                              color: widget.item.hasNewMessage
                                  ? AppColors.greyishBrown
                                  : AppColors.purpleGrey,
                              fontWeight: widget.item.hasNewMessage
                                  ? FontWeight.w500
                                  : FontWeight.normal),
                        )),
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  void showArea1InfoSheet() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => ConsultRoomOptionsWidget(
        nickname: widget.item.nickname,
        onRoomExited: widget.onRoomExited,
      ),
    );
  }
}
