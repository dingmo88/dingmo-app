import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/ui/profile/user/items/user_profile_content_item.dart';
import 'package:dingmo/ui/profile/user/widgets/user_profile_bookmark_tab.dart';
import 'package:dingmo/ui/profile/user/widgets/user_profile_uploads_tab.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/profile_image.dart';
import 'items/user_profile_item.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _PlanProfilePageState();
}

class _PlanProfilePageState extends State<UserProfilePage>
    with TickerProviderStateMixin {
  final int pageSize = 12;
  int maxContentLoad = 5;
  int currentContentLoad = 1;

  late final Future<UserProfileItem> getUserProfileFuture;
  late final UserProfileItem userProfileItem;

  late final TabController tabController;
  final ScrollController scrollController = ScrollController();
  bool isAddedScrollListener = false;
  bool isLoadingNewContents = false;
  bool isLastBookmarksLoaded = false;
  bool isLastUploadsLoaded = false;

  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    getUserProfileFuture = getUserProfile();
    getUserProfileFuture.then((value) => userProfileItem = value);

    scrollController.addListener(handleScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context,
          action: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 20),
                child: GestureDetector(
                    child: Container(
                  padding: const EdgeInsets.all(5),
                  color: Colors.transparent,
                  child: SvgPicture.asset("assets/home/share_icon.svg"),
                )),
              ),
            ],
          )),
      body: FutureBuilder(
          future: getUserProfileFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox(
                width: double.infinity,
                height: 100,
                child: DingmoProgressIndicator(size: 2),
              );
            } else {
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: Dimens.verticalPadding,
                        left: Dimens.horizontalPadding,
                        right: Dimens.horizontalPadding),
                    child: Column(children: [
                      profileWidget(userProfileItem.profileUrl),
                      const SizedBox(height: 15),
                      Texts.defaultText(
                          text: "딩모웨딩",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      const SizedBox(height: 5),
                      Texts.defaultText(
                          text: "웨딩홀",
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 10),
                    ]),
                  ),
                  TabBar(
                      controller: tabController,
                      labelColor: AppColors.greyishBrown,
                      unselectedLabelColor:
                          AppColors.greyishBrown.withOpacity(0.6),
                      indicatorColor: AppColors.greyishBrown,
                      tabs: const [
                        Tab(text: "북마크", height: 45),
                        Tab(text: "게시물", height: 45),
                      ],
                      onTap: (index) {
                        setState(() {});
                      }),
                  [
                    UserProfileBookmarkTab(
                        contents: userProfileItem.bookmarks,
                        isLastBookmarksLoaded: isLastBookmarksLoaded),
                    UserProfileUploadsTab(
                        contents: userProfileItem.uploads,
                        isLastUploadsLoaded: isLastUploadsLoaded)
                  ][tabController.index]
                ]),
              );
            }
          }),
    );
  }

  Widget profileWidget(String? profileUrl) {
    return profileUrl != null
        ? ProfileImageWidget(profileImgKey: profileUrl)
        : const DefaultProfileWidget();
  }

  void handleScrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoadingNewContents) {
      if (tabController.index == 0 && !isLastBookmarksLoaded) {
        isLoadingNewContents = true;
        getNewBookmarks().then((_) => setState(() {
              isLoadingNewContents = false;
            }));
      } else if (tabController.index == 1 && !isLastUploadsLoaded) {
        isLoadingNewContents = true;
        getNewUploads().then((_) => setState(() {
              isLoadingNewContents = false;
            }));
      }
    }
  }

  Future<void> getNewUploads() async {
    if (isLastUploadsLoaded) {
      return;
    }

    final List<UserProfileContentItem> newItems = await getNewUploadsData();

    userProfileItem.uploads.addAll(newItems);
    isLastUploadsLoaded = newItems.isEmpty;
  }

  Future<void> getNewBookmarks() async {
    if (isLastBookmarksLoaded) {
      return;
    }

    final List<UserProfileContentItem> newItems = await getNewBookmarksData();

    userProfileItem.bookmarks.addAll(newItems);
    isLastBookmarksLoaded = newItems.isEmpty;
  }

  Future<List<UserProfileContentItem>> getNewUploadsData() {
    return Future.delayed(const Duration(seconds: 1), () {
      if (currentContentLoad >= maxContentLoad) {
        return [];
      } else {
        currentContentLoad++;
      }
      final List<UserProfileContentItem> contents = [];

      final int startIdx = userProfileItem.bookmarks.length;
      final int end = startIdx + pageSize;

      for (int idx = userProfileItem.bookmarks.length; idx < end; idx++) {
        contents.add(UserProfileContentItem(
            thumbUrl: "https://picsum.photos/id/${455 + idx}/240/240",
            type:
                idx % 4 == 0 ? DingmoContentType.reels : DingmoContentType.feed,
            viewCount: idx * 150));
      }

      return contents;
    });
  }

  Future<List<UserProfileContentItem>> getNewBookmarksData() {
    return Future.delayed(const Duration(seconds: 1), () {
      if (currentContentLoad >= maxContentLoad) {
        return [];
      } else {
        currentContentLoad++;
      }
      final List<UserProfileContentItem> contents = [];

      final int startIdx = userProfileItem.bookmarks.length;
      final int end = startIdx + pageSize;

      for (int idx = userProfileItem.bookmarks.length; idx < end; idx++) {
        contents.add(UserProfileContentItem(
            thumbUrl: "https://picsum.photos/id/${555 + idx}/240/240",
            type:
                idx % 3 == 0 ? DingmoContentType.reels : DingmoContentType.feed,
            viewCount: idx * 100));
      }

      return contents;
    });
  }

  Future<UserProfileItem> getUserProfile() {
    return Future.delayed(const Duration(seconds: 1), () {
      return UserProfileItem(
          profileUrl: "https://picsum.photos/id/567/105/105",
          nickname: "딩모웨딩",
          bookmarks: [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
          ]
              .map((int num) => UserProfileContentItem(
                  thumbUrl: "https://picsum.photos/id/${655 + num}/240/240",
                  type: num % 3 == 0
                      ? DingmoContentType.reels
                      : DingmoContentType.feed,
                  viewCount: num * 100))
              .toList(),
          uploads: [
            1,
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
          ]
              .map((int num) => UserProfileContentItem(
                  thumbUrl: "https://picsum.photos/id/${755 + num}/240/240",
                  type: num % 4 == 0
                      ? DingmoContentType.reels
                      : DingmoContentType.feed,
                  viewCount: num * 150))
              .toList());
    });
  }
}
