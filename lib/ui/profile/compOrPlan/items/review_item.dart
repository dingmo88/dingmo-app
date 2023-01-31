class ReviewItem {
  final String profileUrl;
  final String nickname;
  final String dateCreated;
  final double stars;
  final String comment;
  final List<String> imgUrls;

  final bool isMine;
  final int commentCount;

  bool isLiked;
  int likeCount;

  ReviewItem({
    required this.profileUrl,
    required this.nickname,
    required this.dateCreated,
    required this.stars,
    required this.comment,
    required this.imgUrls,
    required this.isMine,
    required this.isLiked,
    required this.likeCount,
    required this.commentCount,
  });
}
