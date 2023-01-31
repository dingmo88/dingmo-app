class CompProfileItem {
  final String profileUrl;
  final List<String> imageUrls;

  final String nickname;
  final String compName;

  final bool isAllowConsulting;
  final List<String> contentThumbnailUrls;
  final List<ReviewItem> reviews;

  CompProfileItem({
    required this.profileUrl,
    required this.imageUrls,
    required this.nickname,
    required this.compName,
    required this.isAllowConsulting,
    required this.contentThumbnailUrls,
    required this.reviews,
  });
}

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
