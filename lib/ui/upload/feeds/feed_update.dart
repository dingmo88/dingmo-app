import 'dart:async';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_board.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:dingmo/ui/upload/widgets/tag_chip.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/photo_pick_up_list.dart';
import 'package:dingmo/ui/widgets/tagging.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../commons/items/feed_item.dart';
import 'items/feed_upload_form.dart';

class FeedUpdatePage extends StatefulWidget {
  final int contentId;
  const FeedUpdatePage({Key? key, required this.contentId}) : super(key: key);

  @override
  State<FeedUpdatePage> createState() => _FeedUpdatePagePageState();
}

class _FeedUpdatePagePageState extends State<FeedUpdatePage> {
  late final FeedForm _form;
  late final Future<void> _loadFormFuture;

  late final StreamSubscription<bool> keyboardSubscription;

  FocusNode descriptionFocus = FocusNode();
  late final TextEditingController descriptionController =
      TextEditingController(text: _form.description);

  final Map<String, FeedTag> feedTags = {
    "웨딩홀": FeedTag.wedding,
    "스튜디오": FeedTag.studio,
    "메이크업": FeedTag.makeup,
    "드레스": FeedTag.dress,
    "혼수": FeedTag.dowry,
    "기타": FeedTag.etc,
  };

  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((visible) {
      if (!visible && descriptionFocus.hasFocus) {
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
      return null;
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  Future<FeedForm?> _loadForm() async {
    try {
      final result = (await getIt<ApiBoard>()
              .getForm(GetBoardRequest(contentId: widget.contentId)))
          .result;
      FeedForm form = FeedForm(formKey: result.formKey);
      form.description = result.description;
      form.etcTags = result.tag.tags;
      form.feedTag = valueToFeedTag(result.tag.indexTag);
      form.feedImages = result.images
          .map((image) => FormImage<BoardImage>.from(
              image, () => image.imgKey, () => image.imgKey,
              thumbKey: () => image.thumbKey))
          .toList();

      return form;
    } catch (e) {
      safePrint("exception: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isUploading;
      },
      child: IgnorePointer(
          ignoring: _isUploading,
          child: Stack(
            children: [
              FutureBuilder(
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
                      return GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                        },
                        child: Scaffold(
                          appBar: AppBars.defaultAppBar(context,
                              title: "사진 올리기",
                              action: GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();

                                  if (_form.getNewImgCnt() >= 3) {
                                    Fluttertoast.showToast(
                                        msg: "사진 등록으로 최대 몇 분 소요될 수 있습니다",
                                        toastLength: Toast.LENGTH_LONG);
                                  }

                                  if (_form.isAllFilledEssentials()) {
                                    setState(() {
                                      _isUploading = true;
                                    });
                                    final isUploaded = await updateFeed(
                                        await _form.makePatchRequest());

                                    if (isUploaded) {
                                      Fluttertoast.showToast(msg: "수정 완료");
                                      pop();
                                    } else {
                                      setState(() {
                                        _isUploading = false;
                                      });
                                      Fluttertoast.showToast(msg: "수정 실패");
                                    }
                                  }
                                },
                                child: Container(
                                    color: Colors.transparent,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20),
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
                          body: ScrollConfiguration(
                            behavior: NoGlowBehavior(),
                            child: SingleChildScrollView(
                              reverse: true,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 20),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: PhotoPickupListWidget<
                                                  BoardImage>(
                                                showPickWayImagesSheet: true,
                                                initImages: _form.feedImages,
                                                onPickImages: (images) => _form
                                                    .feedImages
                                                    .addAll(images),
                                                onDeleteImage: (image) => _form
                                                    .feedImages
                                                    .removeWhere((feedImage) =>
                                                        feedImage.id() ==
                                                        image.id()),
                                              )),
                                          const SizedBox(height: 10),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 20),
                                              child: Texts.defaultText(
                                                  text:
                                                      "웨딩과 무관한 영상의 경우, 검수를 통하여 미 노출 처리됩니다.",
                                                  fontSize: 12,
                                                  color:
                                                      AppColors.veryLightPink)),
                                        ]),
                                    const SizedBox(height: 25),
                                    TextFormField(
                                        focusNode: descriptionFocus,
                                        controller: descriptionController,
                                        onChanged: (text) => setState(
                                            () => _form.description = text),
                                        keyboardType: TextInputType.multiline,
                                        maxLength: 500,
                                        maxLines: 5,
                                        autofocus: false,
                                        decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 20),
                                            filled: true,
                                            fillColor: AppColors.greyWhite,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            hintText: "사진에 대해 설명해주세요.",
                                            hintStyle: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    AppColors.veryLightPink))),
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
                                              children: feedTags
                                                  .map((name, tag) => MapEntry(
                                                      name,
                                                      TagChip(
                                                          text: name,
                                                          isSelected:
                                                              _form.feedTag ==
                                                                  tag,
                                                          onPressed: () =>
                                                              setState(() =>
                                                                  _form.feedTag =
                                                                      tag))))
                                                  .values
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 20),
                                            Wrap(
                                              spacing: 15,
                                              runSpacing: 15,
                                              children: _form.etcTags
                                                  .asMap()
                                                  .map((index, etcTag) =>
                                                      MapEntry(
                                                          index,
                                                          CustomTagChip(
                                                              text: etcTag,
                                                              onDelete: () =>
                                                                  removeEtcTag(
                                                                      index))))
                                                  .values
                                                  .toList(),
                                            ),
                                            const SizedBox(height: 15),
                                            Container(
                                              height: 1,
                                              color: AppColors.white,
                                            ),
                                            const SizedBox(height: 20),
                                            TaggingWidget(
                                                onSubmitted: addEtcTag),
                                          ]),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
              Visibility(
                  visible: _isUploading,
                  child: Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.mediumPink,
                    ),
                  ))
            ],
          )),
    );
  }

  void pop() {
    Navigator.pop(context, true);
  }

  Future<bool> updateFeed(PatchBoardRequest request) async {
    try {
      await getIt<ApiBoard>().update(request);
      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }

  void removeEtcTag(int index) {
    setState(() => _form.etcTags.removeAt(index));
  }

  void addEtcTag(String tag) {
    setState(() => _form.etcTags.add(tag));
  }

  Future<List<FeedItem>> getFeeds(
      {required int startIdx, required int itemCount}) {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<FeedItem> newFeeds = [];

      if (itemCount > 50) {
        return newFeeds;
      }

      return newFeeds;
    });
  }
}
