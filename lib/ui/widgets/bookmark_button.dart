import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/api/api_bmk_item.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'select_bmk_folder_sheet.dart';
import 'suggest_login_dialog.dart';

class FeedBookmarkButton extends StatelessWidget {
  final int? bmkId;
  final int contentId;
  const FeedBookmarkButton({Key? key, this.bmkId, required this.contentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _BookmarkButtonBase(
        bmkId: bmkId,
        contentId: contentId,
        bmkOnIcon: SvgPicture.asset("assets/home/bookmark_on_icon.svg"),
        bmkOffIcon: SvgPicture.asset("assets/home/bookmark_off_icon.svg",
            color: AppColors.veryLightPink));
  }
}

class BookmarkButton extends StatelessWidget {
  final int? bmkId;
  final int contentId;
  const BookmarkButton({Key? key, this.bmkId, required this.contentId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _BookmarkButtonBase(
        bmkId: bmkId,
        contentId: contentId,
        bmkOnIcon: SvgPicture.asset("assets/home/bookmark_on_icon.svg"),
        bmkOffIcon: SvgPicture.asset("assets/home/bookmark_off_icon.svg"));
  }
}

class _BookmarkButtonBase extends StatefulWidget {
  final int? bmkId;
  final int contentId;
  final Widget bmkOnIcon;
  final Widget bmkOffIcon;
  const _BookmarkButtonBase(
      {Key? key,
      required this.bmkId,
      required this.contentId,
      required this.bmkOnIcon,
      required this.bmkOffIcon})
      : super(key: key);

  @override
  State<_BookmarkButtonBase> createState() => _BookmarkButtonBaseState();
}

class _BookmarkButtonBaseState extends State<_BookmarkButtonBase> {
  late int? bmkId;

  @override
  void initState() {
    super.initState();

    bmkId = widget.bmkId;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (getIt<MemberInfo>().isGuest()) {
          showSuggestLoginDialog(context);
          return;
        }

        if (isBookmarked()) {
          if (await deleteBookmark()) {
            setState(() {
              bmkId = null;
            });
          } else {
            Fluttertoast.showToast(msg: "문제가 발생하였습니다");
          }
        } else {
          showBmkFolderSheet();
        }
      },
      child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 6.5),
          child: isBookmarked() ? widget.bmkOnIcon : widget.bmkOffIcon),
    );
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
              bmkId = result.bmkId;
            });
          }
        },
      ),
    );
  }

  bool isBookmarked() {
    return bmkId != null;
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
      await getIt<ApiBmkItem>().delete(
          DeleteBmkItemRequest(itemId: bmkId!, contentId: widget.contentId));

      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }

  Future<PostBmkItemResult?> createBookmark(GetBmkFolderResult item) async {
    try {
      final response = await getIt<ApiBmkItem>().create(PostBmkItemRequest(
          contentId: widget.contentId, bmkFolderId: item.foldId));

      return response.result;
    } catch (e) {
      safePrint("exception: $e");
    }
    return null;
  }
}
