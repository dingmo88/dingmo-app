import 'package:dingmo/api/api_board.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/third_party/aws_s3_uploader.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';

import 'feed_upload_mention.dart';

enum FeedTag { wedding, studio, makeup, dress, dowry, etc }

FeedTag? valueToFeedTag(int value) {
  switch (value) {
    case 1:
      return FeedTag.wedding;
    case 2:
      return FeedTag.studio;
    case 3:
      return FeedTag.makeup;
    case 4:
      return FeedTag.dress;
    case 5:
      return FeedTag.dowry;
    case 6:
      return FeedTag.etc;
    default:
      return null;
  }
}

int feedTagToValue(FeedTag tag) {
  switch (tag) {
    case FeedTag.wedding:
      return 1;
    case FeedTag.studio:
      return 2;
    case FeedTag.makeup:
      return 3;
    case FeedTag.dress:
      return 4;
    case FeedTag.dowry:
      return 5;
    case FeedTag.etc:
      return 6;
    default:
      return feedTagToValue(FeedTag.etc);
  }
}

class FeedForm {
  final String? formKey;

  List<FormImage<BoardImage>> feedImages = [];
  String? description;
  FeedTag? feedTag;
  List<String> etcTags = [];
  List<FeedUploadMentionItem> mentions = [];

  FeedForm({this.formKey});

  bool isAllFilledEssentials() {
    return feedImages.isNotEmpty &&
        feedTag != null &&
        description?.trim().isNotEmpty == true;
  }

  @override
  String toString() {
    return "ReelsUploadForm(images=$feedImages, description=$description, reelsTag=$feedTag, "
        "etcTags=$etcTags)";
  }

  Future<PostBoardRequest> makePostRequest() async {
    final results = await getIt<AwsS3Uploader>().uploadPhotos(feedImages
        .where((feedImage) => feedImage.isFile())
        .map((feedImage) => feedImage.file())
        .toList());

    return PostBoardRequest(
        thumbKey: results[0].thumbKey,
        images: results
            .map((result) =>
                BoardImage(imgKey: result.imgKey, thumbKey: result.thumbKey))
            .toList(),
        description: description!,
        tag: BoardTag(indexTag: feedTagToValue(feedTag!), tags: etcTags));
  }

  Future<PatchBoardRequest> makePatchRequest() async {
    final results = await getIt<AwsS3Uploader>().uploadPhotos(feedImages
        .where((feedImage) => feedImage.isFile())
        .map((feedImage) => feedImage.file())
        .toList());

    int resultIdx = 0;

    return PatchBoardRequest(
        formKey: formKey!,
        thumbKey: feedImages[0].isFile()
            ? results[0]
                .thumbKey // feedImages[0]가 파일이면 results의 첫번째 요소가 그 업로드 결과다. 왜냐면 순차 접근으로 파일만 골라내서 업로드 했기 때문에.
            : feedImages[0].thumbKey!(),
        images: feedImages.map((feedImage) {
          if (feedImage.isFile()) {
            final boardImage = BoardImage(
                imgKey: results[resultIdx].imgKey,
                thumbKey: results[resultIdx].thumbKey);
            resultIdx += 1;
            return boardImage;
          } else {
            return BoardImage(
                imgKey: feedImage.item().imgKey,
                thumbKey: feedImage.item().thumbKey);
          }
        }).toList(),
        description: description!,
        tag: BoardTag(indexTag: feedTagToValue(feedTag!), tags: etcTags));
  }

  int getNewImgCnt() {
    return feedImages.where((e) => e.isFile()).length;
  }
}
