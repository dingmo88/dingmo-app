import 'package:dingmo/ui/main/mypage/items/notice_item.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class NoticeItemWidget extends StatefulWidget {
  final NoticeItem item;
  const NoticeItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<NoticeItemWidget> createState() => _NoticeItemWidgetState();
}

class _NoticeItemWidgetState extends State<NoticeItemWidget> {
  final ExpandableController expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => expandableController.toggle()),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.title,
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.greyishBrown,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.item.dateCreated,
                        style: TextStyle(
                            fontSize: 12, color: AppColors.veryLightPink),
                      )
                    ],
                  ),
                  expandIcon()
                ]),
          ),
        ),
        ExpandablePanel(
          controller: expandableController,
          collapsed: Container(),
          expanded: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: AppColors.greyWhite,
              child: Text(
                widget.item.content,
                softWrap: true,
                style: TextStyle(
                    fontSize: 13, color: AppColors.greyishBrown, height: 1.5),
              )),
        )
      ],
    );
  }

  Widget expandIcon() {
    return Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: expandableController.expanded
            ? Icon(Icons.keyboard_arrow_up,
                size: 20, color: AppColors.purpleGrey)
            : Icon(Icons.keyboard_arrow_down,
                size: 20, color: AppColors.purpleGrey));
  }
}
