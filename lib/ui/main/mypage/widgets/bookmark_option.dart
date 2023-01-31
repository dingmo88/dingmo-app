import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/widgets/delete_confirm_dialog.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookmarkOptionWidget extends StatefulWidget {
  final int foldId;
  final void Function() onEdit;
  final void Function() onDelete;
  final void Function() onSelect;
  const BookmarkOptionWidget(
      {Key? key,
      required this.foldId,
      required this.onEdit,
      required this.onDelete,
      required this.onSelect})
      : super(key: key);

  @override
  State<BookmarkOptionWidget> createState() => _BookmarkOptionWidgetState();
}

class _BookmarkOptionWidgetState extends State<BookmarkOptionWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isLoading;
      },
      child: IgnorePointer(
        ignoring: _isLoading,
        child: Wrap(
          children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(left: 20, top: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Texts.defaultText(
                                text: "더보기",
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
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            widget.onEdit();
                          },
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "폴더명/비공개 변경",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.greyishBrown),
                            ),
                          )),
                      TextButton(
                          onPressed: showDeleteConfirmDialog,
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "폴더 삭제",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.greyishBrown),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            widget.onSelect();
                          },
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "선택...",
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.greyishBrown),
                            ),
                          )),
                    ],
                  ),
                ),
                Visibility(
                    visible: _isLoading,
                    child: Container(
                      padding: const EdgeInsets.only(top: 100),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.mediumPink,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _deleteFolder() async {
    try {
      await getIt<ApiBmkFolder>()
          .delete(DeleteBmkFolderRequest(folderId: widget.foldId));
      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }

  void showDeleteConfirmDialog() {
    FocusScope.of(context).unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return DeleteConfirmDialog(onYes: () async {
            Navigator.pop(context);

            setState(() {
              _isLoading = true;
            });

            final isDeleted = await _deleteFolder();

            setState(() {
              _isLoading = true;
            });

            if (isDeleted) {
              widget.onDelete();
            } else {
              Fluttertoast.showToast(msg: "삭제 실패");
            }
          });
        });
  }
}
