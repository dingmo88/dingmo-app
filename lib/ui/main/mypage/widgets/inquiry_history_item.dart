import 'package:dingmo/ui/main/mypage/items/inquiry_history_item.dart';
import 'package:dingmo/ui/main/mypage/widgets/inquiry_image_item.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/colors.dart';

class InquiryHistoryItemWidget extends StatefulWidget {
  final InquiryHistoryItem item;
  const InquiryHistoryItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  State<InquiryHistoryItemWidget> createState() =>
      _InquiryHistoryItemWidgetState();
}

class _InquiryHistoryItemWidgetState extends State<InquiryHistoryItemWidget> {
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
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Text(
                            widget.item.title,
                            maxLines: expandableController.expanded ? 2 : 1,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 13,
                                color: AppColors.greyishBrown,
                                fontWeight: FontWeight.w500),
                          )),
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
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              color: AppColors.greyWhite,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.content,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.greyishBrown,
                          height: 1.5),
                    ),
                    const SizedBox(height: 15),
                    imagesWidget(),
                    const SizedBox(height: 15),
                    answerWidget()
                  ])),
        )
      ],
    );
  }

  Widget answerWidget() {
    return widget.item.answer != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 15),
              SvgPicture.asset("assets/mypage/comment_icon.svg",
                  color: AppColors.veryLightPink),
              const SizedBox(height: 10),
              Text(
                widget.item.answer!,
                softWrap: true,
                style: TextStyle(
                    fontSize: 13, color: AppColors.greyishBrown, height: 1.5),
              )
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(height: 10),
              Text(
                "문의가 접수되었습니다. 빠른 시일 내 답변 드리도록 하겠습니다.",
                softWrap: true,
                style: TextStyle(
                    fontSize: 13, color: AppColors.greyishBrown, height: 1.5),
              )
            ],
          );
  }

  Widget imagesWidget() {
    return widget.item.imgUrls != null
        ? Container(
            alignment: Alignment.centerLeft,
            height: 88,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.item.imgUrls!.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InquiryHistoryImgItemWidget(
                    imgUrl: widget.item.imgUrls![index],
                  )),
            ),
          )
        : Container();
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
