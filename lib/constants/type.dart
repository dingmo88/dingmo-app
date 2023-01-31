enum DingmoContentType { reels, feed, review }

DingmoContentType? valueToCtType(int contentType) {
  switch (contentType) {
    case 1:
      return DingmoContentType.reels;
    case 2:
      return DingmoContentType.feed;
    case 3:
      return DingmoContentType.feed;
    default:
      return null;
  }
}

enum LikeType { content, comment }

int likeTypeToValue(LikeType likeType) {
  switch (likeType) {
    case LikeType.content:
      return 1;
    case LikeType.comment:
      return 2;
  }
}
