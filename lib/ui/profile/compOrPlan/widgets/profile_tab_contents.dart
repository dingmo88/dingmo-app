import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path/path.dart';

import '../../../widgets/loading.dart';

class ProfileTabContentItem {
  final String thumbImgKey;
  final int contentId;
  final int contentType;
  final int viewCnt;
  final void Function() onTap;

  ProfileTabContentItem({
    required this.thumbImgKey,
    required this.contentId,
    required this.contentType,
    required this.viewCnt,
    required this.onTap,
  });
}

class ProfileTabContents extends StatefulWidget {
  final List<ProfileTabContentItem> items;
  final bool isLastContentsLoaded;
  const ProfileTabContents(
      {Key? key, required this.items, required this.isLastContentsLoaded})
      : super(key: key);

  @override
  State<ProfileTabContents> createState() => _ProfileTabContentsState();
}

class _ProfileTabContentsState extends State<ProfileTabContents> {
  final int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: widget.items.isNotEmpty
          ? Column(
              children: [
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  children: widget.items
                      .map((item) => GestureDetector(
                            onTap: item.onTap,
                            child: Stack(children: [
                              Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.greyWhite,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Container(
                                            color: AppColors.greyWhite,
                                            child: CachedNetworkImage(
                                              imageUrl: join(Endpoints.imgUrl,
                                                  item.thumbImgKey),
                                              errorWidget: ((context, error,
                                                      stackTrace) =>
                                                  Container()),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Visibility(
                                              visible: valueToCtType(
                                                      item.contentType) ==
                                                  DingmoContentType.reels,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin:
                                                        Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      Colors.black
                                                          .withOpacity(0.15),
                                                      Colors.transparent
                                                    ],
                                                  ),
                                                )),
                                              ))
                                        ],
                                      ))),
                              Visibility(
                                  visible: valueToCtType(item.contentType) ==
                                      DingmoContentType.reels,
                                  child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                      alignment: Alignment.bottomLeft,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/home/icon_awesome_play.svg"),
                                          const SizedBox(width: 4),
                                          Texts.defaultText(
                                              text: item.viewCnt.toString(),
                                              fontSize: 13,
                                              color: Colors.white)
                                        ],
                                      )))
                            ]),
                          ))
                      .toList(),
                ),
                Visibility(
                    visible: !widget.isLastContentsLoaded,
                    child: const DingmoProgressIndicator(
                        size: 40, margin: EdgeInsets.symmetric(vertical: 20))),
                Visibility(
                    visible: widget.isLastContentsLoaded,
                    child: const SizedBox(
                      height: 40,
                    )),
              ],
            )
          : noContentWidget(),
    );
  }

  Widget noContentWidget() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 65),
          Texts.defaultText(
              text: "게시물이 없어요", fontSize: 12, color: AppColors.veryLightPink)
        ],
      ),
    );
  }
}
