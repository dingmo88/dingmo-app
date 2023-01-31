import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'delete_confirm_dialog.dart';

class ContentManageSheet extends StatefulWidget {
  final int contentId;
  final void Function() onEdit;
  final Future<bool> Function() onDelete;
  final void Function()? onAfterDelete;

  const ContentManageSheet(
      {Key? key,
      required this.contentId,
      required this.onEdit,
      required this.onDelete,
      this.onAfterDelete})
      : super(key: key);

  @override
  State<ContentManageSheet> createState() => _ContentManageSheetState();
}

class _ContentManageSheetState extends State<ContentManageSheet> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isDeleting;
      },
      child: IgnorePointer(
        ignoring: _isDeleting,
        child: SizedBox(
          height: 200,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Texts.defaultText(
                          text: "게시물 관리",
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
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        widget.onEdit();
                      },
                      child: Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Texts.defaultText(
                            text: "수정하기",
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      )),
                  GestureDetector(
                      onTap: showDeleteCommentAlertDialog,
                      child: Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Texts.defaultText(
                            text: "삭제하기",
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ))
                ],
              ),
              Visibility(
                  visible: _isDeleting,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.mediumPink,
                    ),
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  void showDeleteCommentAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return DeleteConfirmDialog(onYes: () async {
            setState(() {
              _isDeleting = true;
            });

            final deleteResult = await widget.onDelete();
            if (widget.onAfterDelete != null) {
              widget.onAfterDelete!();
            }

            setState(() {
              _isDeleting = false;
            });

            if (deleteResult) {
              Fluttertoast.showToast(msg: "삭제 처리되었습니다");
              pop();
            } else {
              Fluttertoast.showToast(msg: "문제가 발생하였습니다");
            }
          });
        });
  }

  void pop() {
    Navigator.pop(context);
  }
}
