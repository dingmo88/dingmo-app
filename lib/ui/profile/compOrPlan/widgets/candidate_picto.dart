import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/picto_item.dart';
import 'package:dingmo/ui/profile/compOrPlan/widgets/main_picto_select_sheet.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class CandidatePictoWidget extends StatefulWidget {
  final PictoItem<CompProfilePictorial> item;
  final void Function(int priority) onSelected;
  final void Function() onDeleted;
  const CandidatePictoWidget(
      {Key? key,
      required this.item,
      required this.onSelected,
      required this.onDeleted})
      : super(key: key);

  @override
  State<CandidatePictoWidget> createState() => _CandidatePictoWidgetState();
}

class _CandidatePictoWidgetState extends State<CandidatePictoWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: showMainPictoSelectSheet,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: AppColors.greyWhite,
              child: widget.item.data.isFile()
                  ? Image.file(widget.item.data.file(), fit: BoxFit.cover)
                  : Image.network(
                      path.join(
                          Endpoints.imgUrl,
                          widget.item.data.thumbKey != null
                              ? widget.item.data.thumbKey!()
                              : widget.item.data.imgKey()),
                      fit: BoxFit.cover),
            ),
            Visibility(
                visible: widget.item.isMain,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.pigPink)),
                  child: Wrap(children: [
                    Container(
                        margin: const EdgeInsets.only(left: 5, top: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        color: AppColors.pigPink,
                        child: Text(
                          "메인${widget.item.priority}",
                          style:
                              TextStyle(fontSize: 12, color: AppColors.white),
                        ))
                  ]),
                ))
          ],
        ));
  }

  void showMainPictoSelectSheet() {
    showModalBottomSheet(
        context: context,
        enableDrag: false,
        isDismissible: true,
        builder: (builder) => MainPictoSelectWidget(onSelect: (priority) {
              Navigator.pop(context);
              widget.onSelected(priority);
            }, onDelete: () {
              Navigator.pop(context);
              widget.onDeleted();
            }));
  }
}
