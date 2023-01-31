import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/ui/commons/items/feed_item.dart';
import 'package:dingmo/ui/commons/widgets/feed_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class FeedsPage extends StatefulWidget {
  final Future<List<FeedItem>> Function(int startIdx, int itemCount) getFeeds;
  const FeedsPage({Key? key, required this.getFeeds}) : super(key: key);

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  final int pageSize = 10;
  int maxContentLoad = 5;
  int currentContentLoad = 1;

  bool isLastContentsLoaded = false;
  bool isLoadingNewFeeds = false;

  final List<FeedItem> feeds = [];
  late final Future<void> getFeedsFuture;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getFeedsFuture = getFeeds();
    scrollController.addListener(handleScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context),
      body: FutureBuilder(
          future: getFeedsFuture,
          builder: ((context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox(
                height: 140,
                width: double.infinity,
                child: DingmoProgressIndicator(
                    size: 2, margin: EdgeInsets.only(top: 60)),
              );
            } else {
              return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: feeds.length,
                          itemBuilder: (context, index) => FeedItemWidget(
                              onUpdated: () {},
                              type: FeedItemType.inList,
                              item: feeds[index])),
                      Visibility(
                          visible: !isLastContentsLoaded,
                          child: const DingmoProgressIndicator(
                              size: 40,
                              margin: EdgeInsets.symmetric(vertical: 20))),
                      Visibility(
                          visible: isLastContentsLoaded,
                          child: const SizedBox(
                            height: 40,
                          ))
                    ],
                  ));
            }
          })),
    );
  }

  void handleScrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoadingNewFeeds &&
        !isLastContentsLoaded) {
      isLoadingNewFeeds = true;
      getFeeds().then((_) => setState(() {
            isLoadingNewFeeds = false;
          }));
    }
  }

  Future<void> getFeeds() async {
    if (isLastContentsLoaded) {
      return;
    }

    final List<FeedItem> newItems = await getFeedsData();
    // await preloadImages(newItems);

    feeds.addAll(newItems);
    isLastContentsLoaded = newItems.isEmpty;
  }

  Future<List<FeedItem>> getFeedsData() async {
    return isLastContentsLoaded
        ? []
        : await widget.getFeeds(feeds.length, feeds.length + pageSize);
  }

  Future<void> preloadImages(List<FeedItem> feeds) async {
    for (final feed in feeds) {
      for (final image in feed.images) {
        safePrint('preload: $image');
        await precacheImage(
            NetworkImage(path.join(Endpoints.imgUrl, image.thumbKey, "/")),
            context);
      }
    }
  }
}
