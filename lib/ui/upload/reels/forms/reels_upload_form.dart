import 'dart:io';

import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/third_party/aws_s3_uploader.dart';

enum ReelsTag { wedding, studio, makeup, dress, dowry, etc }

ReelsTag? valueToReelsTag(int value) {
  switch (value) {
    case 1:
      return ReelsTag.wedding;
    case 2:
      return ReelsTag.studio;
    case 3:
      return ReelsTag.makeup;
    case 4:
      return ReelsTag.dress;
    case 5:
      return ReelsTag.dowry;
    case 6:
      return ReelsTag.etc;
    default:
      return null;
  }
}

int reelsTagToValue(ReelsTag tag) {
  switch (tag) {
    case ReelsTag.wedding:
      return 1;
    case ReelsTag.studio:
      return 2;
    case ReelsTag.makeup:
      return 3;
    case ReelsTag.dress:
      return 4;
    case ReelsTag.dowry:
      return 5;
    case ReelsTag.etc:
      return 6;
    default:
      return reelsTagToValue(ReelsTag.etc);
  }
}

class ReelsUploadForm {
  final File videoFile;
  final List<File> thumbFiles = [];
  String? soundAsset;
  String? description;
  int selectedThumbIdx = 0;
  ReelsTag? reelsTag;
  List<String> etcTags = [];

  ReelsUploadForm({required this.videoFile});

  bool isAllFilledEssentials() {
    return reelsTag != null &&
        thumbFiles.isNotEmpty &&
        description?.trim().isNotEmpty == true;
  }

  Future<PostShortsRequest?> makeRequest() async {
    final uploader = getIt<AwsS3Uploader>();

    final videoUploadResult = await uploader.uploadVideo(videoFile);
    if (videoUploadResult == null) {
      return null;
    }

    final thumbUploadResults = await uploader.uploadThumbnails(thumbFiles);
    final thumbKeys =
        thumbUploadResults.map((result) => result.thumbKey).toList();
    final selectedThumbKey = thumbKeys[selectedThumbIdx];
    final shortsThumbs = thumbKeys
        .map((thumbKey) => ShortsThumbnail(
            imgKey: thumbKey, isSelected: selectedThumbKey == thumbKey))
        .toList();

    return PostShortsRequest(
        thumbKey: selectedThumbKey,
        thumbKeys: shortsThumbs,
        m3u8FileKey: videoUploadResult.m3u8Key,
        description: description ?? "",
        tag: ShortsTag(idxTag: reelsTagToValue(reelsTag!), tags: etcTags));
  }

  @override
  String toString() {
    return "ReelsUploadForm(videoFile=$videoFile, soundAsset=$soundAsset,"
        " thumbFiles=$thumbFiles, description=$description, reelsTag=$reelsTag, "
        "etcTags=$etcTags)";
  }
}

class ReelsUpdateForm {
  final String formKey;
  final List<ShortsThumbnail> thumbs;
  String description;
  ReelsTag reelsTag;
  List<String> etcTags;

  ReelsUpdateForm({
    required this.formKey,
    required this.thumbs,
    required this.description,
    required this.reelsTag,
    required this.etcTags,
  });

  bool isAllFilledEssentials() {
    return description.trim().isNotEmpty && thumbs.isNotEmpty;
  }

  void selectThumb(int index) {
    for (var e in thumbs) {
      e.isSelected = false;
    }
    thumbs[index].isSelected = true;
  }

  Future<PatchShortsRequest?> makeRequest() async {
    final selectedThumb = thumbs.where((e) => e.isSelected).first;

    return PatchShortsRequest(
        formKey: formKey,
        thumb:
            EditedShortsThumbnail(selectedThumb: selectedThumb, thumbs: thumbs),
        descr: description,
        tag: ShortsTag(idxTag: reelsTagToValue(reelsTag), tags: etcTags));
  }

  @override
  String toString() {
    return "ReelsUploadForm(formKey=$formKey, thumbs=$thumbs, description=$description, reelsTag=$reelsTag, "
        "etcTags=$etcTags)";
  }
}
