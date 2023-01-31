import 'dart:async';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/upload/reels/widgets/reels_update_thumbnail.dart';
import 'package:dingmo/ui/upload/widgets/tag_chip.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/tagging.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'forms/reels_upload_form.dart';

class ReelsUpdatePage extends StatefulWidget {
  final int contentId;

  const ReelsUpdatePage({Key? key, required this.contentId}) : super(key: key);

  @override
  State<ReelsUpdatePage> createState() => _ReelsUpdatePageState();
}

class _ReelsUpdatePageState extends State<ReelsUpdatePage> {
  late final ReelsUpdateForm _form;
  late final Future<void> _loadFormFuture;

  FocusNode descriptionFocus = FocusNode();
  late final TextEditingController descriptionController =
      TextEditingController(text: _form.description);
  late final StreamSubscription<bool> keyboardSubscription;

  bool _isUploading = false;

  Future<ReelsUpdateForm?> _loadForm() async {
    try {
      final result = (await getIt<ApiShorts>()
              .getForm(GetShortsFormRequest(contentId: widget.contentId)))
          .result;

      return ReelsUpdateForm(
          formKey: result.formKey,
          thumbs: result.thumbs,
          description: result.descr,
          reelsTag: valueToReelsTag(result.tag.idxTag)!,
          etcTags: result.tag.tags);
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
      }
    });

    _loadFormFuture = _loadForm().then((form) {
      if (form == null) {
        Fluttertoast.showToast(msg: "잘못된 접근입니다");
        Navigator.pop(context);
      } else {
        _form = form;
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isUploading;
      },
      child: IgnorePointer(
        ignoring: _isUploading,
        child: Stack(children: [
          GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: FutureBuilder(
                future: _loadFormFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.mediumPink,
                        ),
                      ),
                    );
                  } else {
                    return Scaffold(
                      appBar: AppBars.defaultAppBar(context,
                          title: "딩모숏 올리기",
                          action: GestureDetector(
                            onTap: () async {
                              if (_form.isAllFilledEssentials()) {
                                setState(() {
                                  _isUploading = true;
                                });

                                final request = await _form.makeRequest();
                                if (request == null) {
                                  Fluttertoast.showToast(
                                      msg: "영상 수정 과정에서 문제가 발생하였습니다");
                                  return;
                                }

                                final updateResult =
                                    await apiPatchShorts(request);

                                if (!updateResult) {
                                  setState(() {
                                    _isUploading = false;
                                  });
                                  Fluttertoast.showToast(msg: "수정 실패");
                                } else {
                                  Fluttertoast.showToast(msg: "수정 완료");
                                  pop();
                                }
                              }
                            },
                            child: Container(
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.only(right: 15, left: 20),
                                child: Text(
                                  "완료",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: _form.isAllFilledEssentials()
                                          ? AppColors.mediumPink
                                          : AppColors.veryLightPink),
                                )),
                          )),
                      body: SingleChildScrollView(
                        reverse: true,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimens.horizontalPadding),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 30),
                                      Texts.defaultText(
                                          text: "썸네일 선택", fontSize: 13),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          ReelsUpdateThumbnail(
                                            thumbImgKey: _form.thumbs[0].imgKey,
                                            isSelected:
                                                _form.thumbs[0].isSelected,
                                            onPressed: () {
                                              setState(
                                                  () => _form.selectThumb(0));
                                            },
                                          ),
                                          const SizedBox(width: 20),
                                          ReelsUpdateThumbnail(
                                            thumbImgKey: _form.thumbs[1].imgKey,
                                            isSelected:
                                                _form.thumbs[1].isSelected,
                                            onPressed: () {
                                              setState(
                                                  () => _form.selectThumb(1));
                                            },
                                          ),
                                          const SizedBox(width: 20),
                                          ReelsUpdateThumbnail(
                                            thumbImgKey: _form.thumbs[2].imgKey,
                                            isSelected:
                                                _form.thumbs[2].isSelected,
                                            onPressed: () {
                                              setState(
                                                  () => _form.selectThumb(2));
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Texts.defaultText(
                                          text:
                                              "웨딩과 무관한 영상의 경우, 검수를 통하여 미 노출 처리됩니다.",
                                          fontSize: 12,
                                          color: AppColors.veryLightPink),
                                    ]),
                              ),
                              const SizedBox(height: 25),
                              TextFormField(
                                  focusNode: descriptionFocus,
                                  controller: descriptionController,
                                  onChanged: (text) =>
                                      setState(() => _form.description = text),
                                  keyboardType: TextInputType.multiline,
                                  maxLength: 500,
                                  maxLines: 5,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                      filled: true,
                                      fillColor: AppColors.greyWhite,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: "동영상에 대해 설명해주세요.",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.veryLightPink))),
                              const SizedBox(height: 25),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimens.horizontalPadding),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Texts.defaultText(
                                          text: "필수 태그 (최소 1개 선택)",
                                          fontSize: 13,
                                          color: AppColors.greyishBrown),
                                      const SizedBox(height: 20),
                                      Wrap(
                                        spacing: 15,
                                        runSpacing: 15,
                                        children: [
                                          TagChip(
                                              text: "웨딩홀",
                                              isSelected: _form.reelsTag ==
                                                  ReelsTag.wedding,
                                              onPressed: () => setState(() =>
                                                  _form.reelsTag =
                                                      ReelsTag.wedding)),
                                          TagChip(
                                              text: "스튜디오",
                                              isSelected: _form.reelsTag ==
                                                  ReelsTag.studio,
                                              onPressed: () => setState(() =>
                                                  _form.reelsTag =
                                                      ReelsTag.studio)),
                                          TagChip(
                                              text: "메이크업",
                                              isSelected: _form.reelsTag ==
                                                  ReelsTag.makeup,
                                              onPressed: () => setState(() =>
                                                  _form.reelsTag =
                                                      ReelsTag.makeup)),
                                          TagChip(
                                              text: "드레스",
                                              isSelected: _form.reelsTag ==
                                                  ReelsTag.dress,
                                              onPressed: () => setState(() =>
                                                  _form.reelsTag =
                                                      ReelsTag.dress)),
                                          TagChip(
                                              text: "혼수",
                                              isSelected: _form.reelsTag ==
                                                  ReelsTag.dowry,
                                              onPressed: () => setState(() =>
                                                  _form.reelsTag =
                                                      ReelsTag.dowry)),
                                          TagChip(
                                              text: "기타",
                                              isSelected: _form.reelsTag ==
                                                  ReelsTag.etc,
                                              onPressed: () => setState(() =>
                                                  _form.reelsTag =
                                                      ReelsTag.etc)),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Wrap(
                                        spacing: 15,
                                        runSpacing: 15,
                                        children: _form.etcTags
                                            .asMap()
                                            .map((index, etcTag) => MapEntry(
                                                index,
                                                CustomTagChip(
                                                    text: etcTag,
                                                    onDelete: () =>
                                                        removeEtcTag(index))))
                                            .values
                                            .toList(),
                                      ),
                                      const SizedBox(height: 15),
                                      Container(
                                        height: 1,
                                        color: AppColors.white,
                                      ),
                                      const SizedBox(height: 20),
                                      TaggingWidget(onSubmitted: addEtcTag)
                                    ]),
                              ),
                            ]),
                      ),
                    );
                  }
                }),
          ),
          Visibility(
              visible: _isUploading,
              child: Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.mediumPink,
                ),
              ))
        ]),
      ),
    );
  }

  void pop() {
    Navigator.pop(context, true);
  }

  Future<bool> apiPatchShorts(PatchShortsRequest request) async {
    try {
      await getIt<ApiShorts>().update(request);
    } catch (e) {
      safePrint("exception: $e");
      return false;
    }

    return true;
  }

  void removeEtcTag(int index) {
    setState(() => _form.etcTags.removeAt(index));
  }

  void addEtcTag(String tag) {
    setState(() => _form.etcTags.add(tag.replaceAll(" ", "")));
  }
}
