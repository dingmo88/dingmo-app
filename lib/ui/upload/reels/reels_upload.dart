import 'dart:async';
import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/upload/widgets/tag_chip.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/tagging.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import 'forms/reels_upload_form.dart';
import 'widgets/reels_upload_thumbnail.dart';

class ReelsUploadPage extends StatefulWidget {
  final File videoFile;
  final Duration videoDuration;

  const ReelsUploadPage(
      {Key? key, required this.videoFile, required this.videoDuration})
      : super(key: key);

  @override
  State<ReelsUploadPage> createState() => _ReelsUploadPageState();
}

class _ReelsUploadPageState extends State<ReelsUploadPage> {
  late final ReelsUploadForm form;

  FocusNode descriptionFocus = FocusNode();
  late final TextEditingController descriptionController =
      TextEditingController(text: form.description);
  late final Future<List<File>> thumbnailsFuture;
  late final StreamSubscription<bool> keyboardSubscription;

  bool _isUploading = false;

  Future<List<File>> loadVideoThumbnails() async {
    String fileName = path.basenameWithoutExtension(widget.videoFile.path);
    String dir = path.dirname(widget.videoFile.path);

    List<File> thumbFiles = [
      File(path.join(dir, "$fileName-thumbnail1.png")),
      File(path.join(dir, "$fileName-thumbnail2.png")),
      File(path.join(dir, "$fileName-thumbnail3.png")),
    ];

    if (File(path.join(dir, "$fileName-thumbnail1.png")).existsSync()) {
      return thumbFiles;
    }

    return FFmpegKit.execute(getCommandExtractThumbnails(dir, fileName))
        .then((session) => session.getReturnCode())
        .then((returnCode) => ReturnCode.isSuccess(returnCode))
        .then((isSuccess) {
      if (isSuccess) {
        return thumbFiles;
      } else {
        Fluttertoast.showToast(msg: "문제가 발생했습니다. 다시 시도해주세요.");
        Navigator.pop(context);
        return [File(""), File(""), File("")];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    form = ReelsUploadForm(videoFile: widget.videoFile);

    thumbnailsFuture = loadVideoThumbnails();
    thumbnailsFuture.then(form.thumbFiles.addAll).then((_) => setState(() {}));
    keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
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
            child: Scaffold(
              appBar: AppBars.defaultAppBar(context,
                  title: "딩모숏 올리기",
                  action: GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (form.isAllFilledEssentials()) {
                        setState(() {
                          _isUploading = true;
                        });

                        final request = await form.makeRequest();
                        if (request == null) {
                          Fluttertoast.showToast(
                              msg: "영상 업로드 과정에서 문제가 발생하였습니다");
                          return;
                        }

                        final createResult = await apiCreateShorts(request);

                        if (!createResult) {
                          setState(() {
                            _isUploading = false;
                          });
                          Fluttertoast.showToast(msg: "등록 실패");
                        } else {
                          Fluttertoast.showToast(
                              msg: "등록 완료! 반영까지 몇 분 정도 소요됩니다");
                          popUntilFirst();
                        }
                      }
                    },
                    child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 15, left: 20),
                        child: Text(
                          "완료",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: form.isAllFilledEssentials()
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Texts.defaultText(text: "썸네일 선택", fontSize: 13),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  ReelsUploadThumbnail(
                                    imagesFuture: thumbnailsFuture,
                                    index: 0,
                                    isSelected: form.selectedThumbIdx == 0,
                                    onPressed: () {
                                      setState(() => form.selectedThumbIdx = 0);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  ReelsUploadThumbnail(
                                    imagesFuture: thumbnailsFuture,
                                    index: 1,
                                    isSelected: form.selectedThumbIdx == 1,
                                    onPressed: () {
                                      setState(() => form.selectedThumbIdx = 1);
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  ReelsUploadThumbnail(
                                    imagesFuture: thumbnailsFuture,
                                    index: 2,
                                    isSelected: form.selectedThumbIdx == 2,
                                    onPressed: () {
                                      setState(() => form.selectedThumbIdx = 2);
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Texts.defaultText(
                                  text: "웨딩과 무관한 영상의 경우, 검수를 통하여 미 노출 처리됩니다.",
                                  fontSize: 12,
                                  color: AppColors.veryLightPink),
                            ]),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                          focusNode: descriptionFocus,
                          controller: descriptionController,
                          onChanged: (text) =>
                              setState(() => form.description = text),
                          keyboardType: TextInputType.multiline,
                          maxLength: 500,
                          maxLines: 5,
                          autofocus: false,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                      isSelected:
                                          form.reelsTag == ReelsTag.wedding,
                                      onPressed: () => setState(() =>
                                          form.reelsTag = ReelsTag.wedding)),
                                  TagChip(
                                      text: "스튜디오",
                                      isSelected:
                                          form.reelsTag == ReelsTag.studio,
                                      onPressed: () => setState(() =>
                                          form.reelsTag = ReelsTag.studio)),
                                  TagChip(
                                      text: "메이크업",
                                      isSelected:
                                          form.reelsTag == ReelsTag.makeup,
                                      onPressed: () => setState(() =>
                                          form.reelsTag = ReelsTag.makeup)),
                                  TagChip(
                                      text: "드레스",
                                      isSelected:
                                          form.reelsTag == ReelsTag.dress,
                                      onPressed: () => setState(() =>
                                          form.reelsTag = ReelsTag.dress)),
                                  TagChip(
                                      text: "혼수",
                                      isSelected:
                                          form.reelsTag == ReelsTag.dowry,
                                      onPressed: () => setState(() =>
                                          form.reelsTag = ReelsTag.dowry)),
                                  TagChip(
                                      text: "기타",
                                      isSelected: form.reelsTag == ReelsTag.etc,
                                      onPressed: () => setState(
                                          () => form.reelsTag = ReelsTag.etc)),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Wrap(
                                spacing: 15,
                                runSpacing: 15,
                                children: form.etcTags
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
            ),
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

  void popUntilFirst() {
    Navigator.pushNamedAndRemoveUntil(context, Routes.start, (route) => false);
  }

  Future<bool> apiCreateShorts(PostShortsRequest request) async {
    try {
      await getIt<ApiShorts>().create(request);
    } catch (e) {
      safePrint("exception: $e");
      return false;
    }

    return true;
  }

  void removeEtcTag(int index) {
    setState(() => form.etcTags.removeAt(index));
  }

  void addEtcTag(String tag) {
    setState(() => form.etcTags.add(tag.replaceAll(" ", "")));
  }

  String getCommandExtractThumbnails(String dir, String filename) {
    int thumbCount = 3;
    int videoSeconds = widget.videoDuration.inSeconds;
    double fps = thumbCount / videoSeconds;
    return "-i ${widget.videoFile.path}"
        " -vf fps=$fps ${path.join(dir, "$filename-thumbnail%d.png")}";
  }
}
