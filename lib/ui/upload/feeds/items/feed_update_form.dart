import 'dart:io';

import 'feed_upload_mention.dart';

enum FeedTag { wedding, studio, makeup, dress, dowry, etc }

class FeedUpdateForm {
  static final FeedUpdateForm _instance = FeedUpdateForm._internal();

  String? description;
  List<File> oldImages = [];
  List<File> newImages = [];
  List<FeedTag> feedTags = [];
  List<String> etcTags = [];
  String? area1;
  String? area2;
  List<FeedUploadMentionItem> mentions = [];

  FeedUpdateForm._internal();

  factory FeedUpdateForm.instance() {
    return _instance;
  }

  bool isAllFilledEssentials() {
    return newImages.isNotEmpty &&
        feedTags.isNotEmpty &&
        area1 != null &&
        area2 != null;
  }

  @override
  String toString() {
    return "ReelsUploadForm(images=$newImages, description=$description, reelsTag=$feedTags, "
        "etcTags=$etcTags)";
  }

  void clearAll() {
    newImages.clear();
    feedTags.clear();
    etcTags.clear();
  }
}
