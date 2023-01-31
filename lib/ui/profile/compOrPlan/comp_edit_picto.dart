import 'dart:io';

import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/picto_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/add_picto_button.dart';
import 'widgets/candidate_picto.dart';
import 'widgets/comp_preview_image.dart';

class CompEditPictoPage extends StatefulWidget {
  final List<PictoItem<CompProfilePictorial>> initPictos;
  final void Function(List<PictoItem<CompProfilePictorial>> pictos)
      onPictoSelected;
  const CompEditPictoPage(
      {Key? key, required this.initPictos, required this.onPictoSelected})
      : super(key: key);

  @override
  CompEditPictoPageState createState() => CompEditPictoPageState();
}

class CompEditPictoPageState extends State<CompEditPictoPage> {
  final List<PictoItem<CompProfilePictorial>> _pictos = [];

  @override
  void initState() {
    super.initState();

    _pictos.addAll(widget.initPictos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context,
          title: "화보 사진 관리",
          action: GestureDetector(
            onTap: () {
              final pictos = _pictos
                  .where((e) => e != null)
                  .map((e) => e as PictoItem<CompProfilePictorial>)
                  .toList();

              widget.onPictoSelected(pictos);
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 30, left: 30),
              child: Text(
                "완료",
                style: TextStyle(
                    color: AppColors.mediumPink,
                    fontSize: 13,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("메인 미리보기",
                        style: TextStyle(
                            color: AppColors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        CompEditPreviewImageMain(picto: _getMainPicto(1)),
                        const SizedBox(width: 6),
                        Column(children: [
                          CompEditPreviewImageSub(picto: _getMainPicto(2)),
                          const SizedBox(height: 5),
                          CompEditPreviewImageSub(picto: _getMainPicto(3)),
                          const SizedBox(height: 5),
                          CompEditPreviewImageSub(picto: _getMainPicto(4)),
                        ])
                      ],
                    ),
                    const SizedBox(height: 20),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "아래 불러온 사진 중 ",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.purpleGrey)),
                      TextSpan(
                          text: "메인 사진 3개",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.mediumPink)),
                      TextSpan(
                          text: "를 선택해주세요.",
                          style: TextStyle(
                              fontSize: 12, color: AppColors.purpleGrey)),
                    ])),
                  ],
                ),
              ),
              Expanded(
                  child: ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: _pictos.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index == 0
                        ? AddPictoButton(
                            onPickImages: (List<File> images) {
                              setState(() {
                                if (_pictos.isEmpty) {
                                  _pictos.addAll(images.map((e) {
                                    final picto = FormImage<
                                            CompProfilePictorial>.fromFile(
                                        e, () => e.path);

                                    return PictoItem<CompProfilePictorial>(
                                        picto, false, 0);
                                  }));
                                } else {
                                  _pictos.insertAll(1, images.map((e) {
                                    final picto = FormImage<
                                            CompProfilePictorial>.fromFile(
                                        e, () => e.path);

                                    return PictoItem<CompProfilePictorial>(
                                        picto, false, 0);
                                  }));
                                }
                              });
                            },
                          )
                        : CandidatePictoWidget(
                            item: _pictos[index - 1],
                            onSelected: (priority) {
                              setState(() {
                                final picto = _pictos
                                    .where((e) => e.priority == priority)
                                    .toList();

                                if (picto.isNotEmpty) {
                                  picto[0].setMain(false, 0);
                                }

                                _pictos[index - 1].setMain(true, priority);
                              });
                            },
                            onDeleted: () {
                              setState(() {
                                _pictos.removeAt(index - 1);
                              });
                            },
                          );
                  },
                ),
              ))
            ],
          )),
    );
  }

  PictoItem<CompProfilePictorial>? _getMainPicto(int priority) {
    final picto = _pictos
        .where((e) => e.isMain == true && e.priority == priority)
        .toList();

    return picto.isEmpty ? null : picto[0];
  }
}
