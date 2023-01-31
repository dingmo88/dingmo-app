import '../../../ui/commons/items/feed_item.dart';

class FeedsArgs {
  final Future<List<FeedItem>> Function(int startIdx, int itemCount) getFeeds;

  FeedsArgs({required this.getFeeds});
}
