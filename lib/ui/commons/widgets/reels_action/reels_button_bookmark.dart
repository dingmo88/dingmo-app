import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/api/api_bmk_item.dart';
import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/widgets/select_bmk_folder_sheet.dart';
import 'package:dingmo/ui/widgets/suggest_login_dialog.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReelsButtonBookmark extends StatefulWidget {
  final GetShortsResult data;
  final Future<void> Function() onLoginSuggestStarted;
  final Future<void> Function() onLoginSuggestEnded;
  const ReelsButtonBookmark(
      {Key? key,
      required this.data,
      required this.onLoginSuggestStarted,
      required this.onLoginSuggestEnded})
      : super(key: key);

  @override
  State<ReelsButtonBookmark> createState() => _ReelsButtonBookmarkState();
}

class _ReelsButtonBookmarkState extends State<ReelsButtonBookmark> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          if (getIt<MemberInfo>().isGuest()) {
            showSuggestLoginDialog();
            return;
          }

          if (isBookmarked()) {
            if (await deleteBookmark()) {
              setState(() {
                widget.data.bmkId = null;
                widget.data.boomkmarkCnt -= 1;
              });
            } else {
              Fluttertoast.showToast(msg: "문제가 발생하였습니다");
            }
          } else {
            showBmkFolderSheet();
          }
        },
        child: Column(
          children: [
            Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 50.0,
                      spreadRadius: 20.0,
                    )
                  ],
                ),
                child: SvgPicture.asset(widget.data.bmkId != null
                    ? "assets/home/bookmark_on_icon.svg"
                    : "assets/home/bookmark_off_icon.svg")),
            const SizedBox(height: 5),
            Texts.defaultText(
                text: "${widget.data.boomkmarkCnt}",
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.normal)
          ],
        ));
  }

  bool isBookmarked() {
    return widget.data.bmkId != null;
  }

  Future<List<GetBmkFolderResult>?> getFolders() async {
    try {
      final response = await getIt<ApiBmkFolder>().getList();
      return response.result;
    } catch (e) {
      safePrint("exception: $e");
    }
    return null;
  }

  Future<bool> deleteBookmark() async {
    try {
      await getIt<ApiBmkItem>().delete(DeleteBmkItemRequest(
          itemId: widget.data.bmkId!, contentId: widget.data.contentId));

      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }

  Future<PostBmkItemResult?> createBookmark(GetBmkFolderResult item) async {
    try {
      final response = await getIt<ApiBmkItem>().create(PostBmkItemRequest(
          contentId: widget.data.contentId, bmkFolderId: item.foldId));

      return response.result;
    } catch (e) {
      safePrint("exception: $e");
    }
    return null;
  }

  void showBmkFolderSheet() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      isScrollControlled: true,
      builder: (context) => SelectBmkFolderSheet(
        getFolders: getFolders(),
        onFolderSelected: (folder) async {
          final result = await createBookmark(folder);

          if (result == null) {
            Fluttertoast.showToast(msg: "문제가 발생하였습니다");
          } else {
            setState(() {
              widget.data.bmkId = result.bmkId;
              widget.data.boomkmarkCnt += 1;
            });
          }
        },
      ),
    );
  }

  void showSuggestLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => SuggestLoginDialog(
              onYes: widget.onLoginSuggestStarted,
              onFinished: widget.onLoginSuggestEnded,
            ));
  }
}
