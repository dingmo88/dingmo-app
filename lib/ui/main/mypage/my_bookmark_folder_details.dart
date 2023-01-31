import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/api/api_bmk_item.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/main/mypage/items/bookmark_folder_details_item.dart';
import 'package:dingmo/ui/main/mypage/widgets/bookmark_edit_folder.dart';
import 'package:dingmo/ui/main/mypage/widgets/bookmark_folder_details.dart';
import 'package:dingmo/ui/main/mypage/widgets/bookmark_folder_item_option.dart';
import 'package:dingmo/ui/main/mypage/widgets/bookmark_option.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/delete_confirm_dialog.dart';
import 'package:dingmo/ui/widgets/infinity_grid.dart';
import 'package:dingmo/ui/widgets/select_bmk_folder_sheet.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import 'items/bookmark_folder_item.dart';

class MybookmarkFolderDetailsPage extends StatefulWidget {
  final BookmarkFolderItem item;
  final void Function(BookmarkFolderItem editedItem) onFolderEdited;
  final void Function() onFolderDeleted;

  const MybookmarkFolderDetailsPage(
      {Key? key,
      required this.item,
      required this.onFolderEdited,
      required this.onFolderDeleted})
      : super(key: key);

  @override
  State<MybookmarkFolderDetailsPage> createState() =>
      _MybookmarkFolderDetailsPageState();
}

class _MybookmarkFolderDetailsPageState
    extends State<MybookmarkFolderDetailsPage> {
  bool _isItemCheckable = false;

  final InfinityGridController<BookmarkFolderDetailsItem> gridController =
      InfinityGridController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.titleWidgetAppBar(context,
          title: widget.item.isSecret
              ? Row(
                  children: [
                    SvgPicture.asset(
                      "assets/mypage/lock_icon.svg",
                      color: AppColors.greyishBrown,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.item.folderName,
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.greyishBrown,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Text(
                  widget.item.folderName,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.greyishBrown,
                      fontWeight: FontWeight.bold),
                ),
          action: GestureDetector(
              onTap: () => showBookmarkOptionSheet(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                color: Colors.transparent,
                child: SvgPicture.asset("assets/mypage/dots_icon.svg"),
              ))),
      body: WillPopScope(
          onWillPop: () async {
            if (_isItemCheckable) {
              setState(() {
                _isItemCheckable = false;
                gridController.getList().forEach((e) => e.isSelected = false);
              });
              return false;
            }
            return true;
          },
          child: SafeArea(
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: InfinityGridWidget<BookmarkFolderDetailsItem>(
                    controller: gridController,
                    gridConfig: GridConfig(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1),
                    onLoad: _getBookmarkFolderDetails,
                    pageSize: 10,
                    itemBuilder: (BuildContext context,
                            BookmarkFolderDetailsItem item) =>
                        BookmarkFolderDetailItemWidget(
                            item: item, isCheckable: _isItemCheckable),
                  ),
                ),
              ),
              Visibility(
                  visible: _isItemCheckable,
                  child: Column(
                    children: [
                      const Spacer(),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        color: AppColors.greyWhite,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BookmarkFolderItemOptionButton(
                                  assetUrl: "assets/mypage/arrowout_icon.svg",
                                  name: "폴더 이동",
                                  onPressed: showTransferFolderSheet),
                              BookmarkFolderItemOptionButton(
                                  assetUrl:
                                      "assets/mypage/icon_feather_trash.svg",
                                  name: "삭제",
                                  onPressed: showDeleteConfirmDialog),
                            ]),
                      )
                    ],
                  ))
            ]),
          )),
    );
  }

  Future<List<BookmarkFolderDetailsItem>> _getBookmarkFolderDetails(
      int page, int size) async {
    try {
      final result = (await getIt<ApiBmkItem>().getList(GetBmkItemRequest(
              foldId: widget.item.folderId, page: page, size: size)))
          .result;

      return result
          .map((e) => BookmarkFolderDetailsItem(
                itemId: e.bmkItemId,
                foldId: e.bmkFolderId,
                contentId: e.contentId,
                contentType: valueToCtType(e.contentType)!,
                thumbnailUrl: path.join(Endpoints.imgUrl, e.contentThumbKey),
                memberType: valueToMemberType(e.profileType)!,
                compType: valueToIdxTag(e.compType),
                nickname: e.nickname,
              ))
          .toList();
    } catch (e) {
      safePrint("exception: $e");
    }

    return [];
  }

  void showBookmarkOptionSheet() {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        builder: (builder) => BookmarkOptionWidget(
              foldId: widget.item.folderId,
              onEdit: showEditBookmarkSheet,
              onDelete: () {
                widget.onFolderDeleted();
                Fluttertoast.showToast(msg: "삭제되었습니다");
                Navigator.pop(context);
              },
              onSelect: () {
                setState(() {
                  _isItemCheckable = true;
                });
              },
            ));
  }

  void showEditBookmarkSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: false,
        builder: (builder) => BookmarkEditFolderWidget(
              item: widget.item,
              onEditCompleted: (BookmarkFolderItem newItem) {
                widget.onFolderEdited(newItem);
                setState(() {
                  widget.item.folderName = newItem.folderName;
                  widget.item.isSecret = newItem.isSecret;
                });

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "폴더가 변경되었습니다.",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ));
              },
            ));
  }

  void showTransferFolderSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (builder) => SelectBmkFolderSheet(
              getFolders: getFolders(),
              onFolderSelected: (folder) async {
                if (await updateBmkItems(folder.foldId, getSelectedItemIds())) {
                  if (folder.foldId != widget.item.folderId) {
                    removeSelectedItems();
                  }
                  setState(() {
                    _isItemCheckable = false;
                  });
                  showSnackBar("이동되었습니다.");
                } else {
                  Fluttertoast.showToast(msg: "문제가 발생하였습니다");
                }
              },
            ));
  }

  void showDeleteConfirmDialog() async {
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return DeleteConfirmDialog(onYes: () async {
            if (await deleteBmkItems(getSelectedItemDatas())) {
              removeSelectedItems();
              setState(() {
                _isItemCheckable = false;
              });
              showSnackBar("삭제되었습니다.");
            } else {
              Fluttertoast.showToast(msg: "문제가 발생하였습니다");
            }
          });
        });
  }

  Future<bool> deleteBmkItems(List<DeleteBmkItemData> items) async {
    try {
      await getIt<ApiBmkItem>()
          .deleteMultipe(DeleteBmkItemsRequest(items: items));
      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }

  Future<bool> updateBmkItems(int foldId, List<int> itemIds) async {
    try {
      await getIt<ApiBmkItem>()
          .update(PatchBmkItemRequest(foldId: foldId, itemIds: itemIds));

      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
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

  List<DeleteBmkItemData> getSelectedItemDatas() {
    return gridController
        .getList()
        .where((e) => e.isSelected)
        .map((e) => DeleteBmkItemData(itemId: e.itemId, contentId: e.contentId))
        .toList();
  }

  List<int> getSelectedItemIds() {
    return gridController
        .getList()
        .where((item) => item.isSelected)
        .map((item) => item.itemId)
        .toList();
  }

  void removeSelectedItems() {
    setState(() {
      gridController.getList().removeWhere((item) {
        if (item.isSelected) {}
        return item.isSelected;
      });
      gridController.notifyItemChanged();
    });
  }

  void showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.white),
      ),
    ));
  }
}
