import 'package:dingmo/api/api_board.dart';

class FeedItem {
  int contentId;
  String? profileUrl;
  String nickname;
  String description;
  String dateCreated;
  List<BoardImage> images;
  List<BoardMention> mentions;
  List<String> tags;
  int likeCount;
  int commentCount;
  int? bmkId;
  bool isLiked;
  bool isMine;

  FeedItem(
      {required this.contentId,
      required this.profileUrl,
      required this.nickname,
      required this.description,
      required this.dateCreated,
      required this.images,
      required this.mentions,
      required this.tags,
      required this.likeCount,
      required this.commentCount,
      required this.bmkId,
      required this.isLiked,
      required this.isMine});
}
