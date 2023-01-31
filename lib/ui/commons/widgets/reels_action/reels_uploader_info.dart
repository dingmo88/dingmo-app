import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/routes/arguments/args_search_result.dart';
import 'package:dingmo/ui/upload/reels/items/reels_item.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

class ReelsUploaderInfoWidget extends StatefulWidget {
  final ReelsItem reelsInfo;
  final VoidFuncFuture onPressedUploader;

  const ReelsUploaderInfoWidget(
      {Key? key, required this.reelsInfo, required this.onPressedUploader})
      : super(key: key);

  @override
  State<ReelsUploaderInfoWidget> createState() =>
      _ReelsUploaderInfoWidgetState();
}

class _ReelsUploaderInfoWidgetState extends State<ReelsUploaderInfoWidget> {
  late final ReelsItem info;

  final ExpandableController expandableController = ExpandableController();

  @override
  void initState() {
    super.initState();

    info = widget.reelsInfo;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (expandableController.expanded) {
          expandableController.toggle();
          return false;
        } else {
          return true;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          GestureDetector(
            onTap: () async {
              await widget.onPressedUploader();
            },
            child: Row(
              children: [
                Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.greyWhite,
                        border:
                            Border.all(color: AppColors.greyWhite, width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: info.data.profileImgKey != null
                          ? CachedNetworkImage(
                              imageUrl: path.join(
                                  Endpoints.imgUrl, info.data.profileImgKey!),
                              fit: BoxFit.cover)
                          : Image.asset("assets/dingmo.png"),
                    )),
                const SizedBox(
                  width: 10,
                ),
                Texts.defaultText(
                    text: info.data.nickname,
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.normal),
                const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                  size: 20,
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Wrap(
                spacing: 2,
                children: info.data.tags.isNotEmpty
                    ? info.data.tags
                        .map((e) => GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.searchResult,
                                    arguments: SearchResultArgs(keyword: e));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 2),
                                child: Texts.defaultText(
                                    text: "#$e",
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                              ),
                            ))
                        .toList()
                    : [],
              )),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () => setState(() => expandableController.toggle()),
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width - 100,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Flexible(
                    child: ExpandablePanel(
                  controller: expandableController,
                  collapsed: Text(
                    info.data.description,
                    softWrap: true,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.white, height: 1.2),
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Text(
                    info.data.description,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 13, color: Colors.white, height: 1.2),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  child: expandIcon(),
                )
              ]),
            ),
          )
        ],
      ),
    );
  }

  bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }

  Widget expandIcon() {
    return hasTextOverflow(info.data.description,
            const TextStyle(fontSize: 13, color: Colors.white, height: 1.2),
            maxLines: 2, maxWidth: MediaQuery.of(context).size.width * 0.45)
        ? expandableController.expanded
            ? const Icon(Icons.keyboard_arrow_up_outlined,
                size: 20, color: Colors.white)
            : const Icon(Icons.keyboard_arrow_down_outlined,
                size: 20, color: Colors.white)
        : Container();
  }
}
