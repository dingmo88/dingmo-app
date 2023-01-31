import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import '../../constants/colors.dart';
import '../main/mypage/widgets/bookmark_add_folder.dart';
import 'texts.dart';

class SelectBmkFolderSheet extends StatelessWidget {
  final void Function(GetBmkFolderResult folder) onFolderSelected;
  final Future<List<GetBmkFolderResult>?> getFolders;

  const SelectBmkFolderSheet(
      {Key? key, required this.onFolderSelected, required this.getFolders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.4,
      initialChildSize: 0.4,
      maxChildSize: 0.9,
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
                      text: "북마크에 담기",
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
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
            FutureBuilder<List<GetBmkFolderResult>?>(
                future: getFolders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.mediumPink,
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ScrollConfiguration(
                        behavior: NoGlowBehavior(),
                        child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showAddBookmarkSheet(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius:
                                              BorderRadius.circular(99)),
                                      child: SvgPicture.asset(
                                        "assets/home/plus_icon.svg",
                                        color: AppColors.greyishBrown,
                                        width: 11,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      "새 폴더 추가",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.greyishBrown),
                                    )
                                  ]),
                                )),
                            ...((snapshot.data ?? [])
                                .map((folder) => TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      onFolderSelected(folder);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                      child: Row(children: [
                                        Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.veryLightPink,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: CachedNetworkImage(
                                                imageUrl: path.join(
                                                    Endpoints.imgUrl,
                                                    folder.foldThumbKey),
                                                fit: BoxFit.cover,
                                                errorWidget: (context,
                                                    exception, stackTrace) {
                                                  return Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5),
                                                    alignment: Alignment.center,
                                                    child: Image.asset(
                                                      "assets/dingmo.png",
                                                    ),
                                                  );
                                                })),
                                        const SizedBox(width: 15),
                                        Text(
                                          folder.foldName,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.greyishBrown),
                                        )
                                      ]),
                                    )))
                                .toList())
                          ],
                        ),
                      ),
                    );
                  }
                })
          ],
        );
      },
    );
  }

  void showAddBookmarkSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: false,
        builder: (builder) => BookmarkAddFolderWidget(
              onAddCompleted: (newFolder) {
                Fluttertoast.showToast(msg: "폴더가 추가되었습니다.");
              },
            ));
  }
}
