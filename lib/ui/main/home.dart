import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:camera/camera.dart';
import 'package:dingmo/api/api_profile.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_feed_upload.dart';
import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:dingmo/routes/arguments/args_reels_filming.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/home/search_tab.dart';
import 'package:dingmo/ui/main/mypage/mypage_tab.dart';
import 'package:dingmo/ui/main/shorts/reels_tab.dart';
import 'package:dingmo/ui/main/widgets/reels_upload_button.dart';
import 'package:dingmo/utils/reels_paging_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home/widgets/home_fab_menu.dart';

class HomePage extends StatefulWidget {
  final int initTabIndex;
  const HomePage({Key? key, this.initTabIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late final AnimationController _controller;
  late final Animation<Color?> _menuButtonColor;
  late final Animation<Color?> _menuButtonIconColor;

  late Animation<double> _animation;

  DateTime currentBackPressTime = DateTime.now();

  int _selectedIndex = 0;

  late final ReelsPagingManager reelsPagingManager =
      getIt<ReelsPagingManager>();

  late final List<Widget> _bottomMenus = [
    ReelsTab(onSelected: () => _selectedIndex == 0),
    const SearchTab(),
    const MypageTab(),
    const MypageTab(),
  ];

  @override
  void initState() {
    super.initState();
    reelsPagingManager.setReelsDisplayed(isSelectedReelsTab());

    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _menuButtonColor = ColorTween(
      begin: AppColors.greyishBrown,
      end: Colors.white,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.ease,
      ),
    ));

    _menuButtonIconColor = ColorTween(
      begin: Colors.white,
      end: AppColors.greyishBrown,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.00,
        1.00,
        curve: Curves.ease,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor:
              _selectedIndex == 0 ? Colors.black : Colors.white),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            IndexedStack(
              index: _selectedIndex,
              children: _bottomMenus,
            ),
            Visibility(
                visible: _controller.status == AnimationStatus.completed,
                child: FadeTransition(
                  opacity: _animation,
                  child: GestureDetector(
                      onTap: () async {
                        await _controller.reverse();
                        setState(() {});
                      },
                      child: Container(
                        color: Colors.black.withOpacity(0.4),
                      )),
                )),
            Visibility(
                visible: _controller.status == AnimationStatus.completed,
                child: FadeTransition(
                    opacity: _animation,
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 40, right: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Wrap(direction: Axis.vertical, children: [
                            HomeFABMenuWidget(
                              icon: SvgPicture.asset(
                                  "assets/home/plotting_photo_icon.svg"),
                              label: "사진 올리기",
                              onPressed: pickImages,
                            ),
                            HomeFABMenuWidget(
                              icon: SvgPicture.asset(
                                  "assets/home/plotting_shots_icon.svg"),
                              label: "딩모숏 올리기",
                              onPressed: () {
                                existsArea().then((exists) {
                                  if (!exists) {
                                    Fluttertoast.showToast(
                                        msg: "프로필에서 위치 등록 후 이용하실 수 있습니다");
                                    return;
                                  }
                                  chagePage(2);

                                  availableCameras().then((cameras) {
                                    Navigator.pushNamed(
                                        context, Routes.reelsFilming,
                                        arguments: ReelsFilmingArgs(
                                            backCamera: cameras
                                                .firstWhere(isBackCamera),
                                            frontCamera: cameras
                                                .lastWhere(isFrontCamera)));
                                  });
                                });
                              },
                            ),
                            Visibility(
                                visible: getIt<MemberInfo>().memberType ==
                                    MemberType.user,
                                child: HomeFABMenuWidget(
                                  icon: SvgPicture.asset(
                                      "assets/home/review_icon.svg"),
                                  label: "후기 올리기",
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.searchCompsForReview);
                                  },
                                )),
                          ]),
                        )))),
          ]),
          bottomNavigationBar: Stack(children: [
            BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedItemColor:
                  _selectedIndex == 0 ? Colors.white : AppColors.mediumPink,
              unselectedItemColor:
                  _selectedIndex == 0 ? Colors.white : AppColors.greyishBrown,
              backgroundColor:
                  _selectedIndex == 0 ? Colors.black : Colors.white,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              currentIndex: _selectedIndex,
              onTap: chagePage,
              items: [
                BottomNavigationBarItem(
                  label: '홈',
                  icon: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _isSelectedHome()
                        ? SvgPicture.asset(
                            "assets/bottom_navi/dark_mode/home_icon.svg",
                          )
                        : SvgPicture.asset(
                            "assets/bottom_navi/light_mode/home_icon.svg",
                          ),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '탐색',
                  icon: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _isSelectedHome()
                        ? SvgPicture.asset(
                            "assets/bottom_navi/dark_mode/navi_search_icon.svg",
                          )
                        : (_isSelectedSearch()
                            ? SvgPicture.asset(
                                "assets/bottom_navi/light_mode/navi_search_icon_selected.svg",
                              )
                            : SvgPicture.asset(
                                "assets/bottom_navi/light_mode/navi_search_icon.svg",
                              )),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '마이페이지',
                  icon: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 4),
                    child: _isSelectedHome()
                        ? SvgPicture.asset(
                            "assets/bottom_navi/dark_mode/mypage_icon.svg",
                          )
                        : (_isSelectedMypage()
                            ? SvgPicture.asset(
                                "assets/bottom_navi/light_mode/mypage_icon_selected.svg",
                              )
                            : SvgPicture.asset(
                                "assets/bottom_navi/light_mode/mypage_icon.svg",
                              )),
                  ),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(),
                ),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                ContentUploadButton(
                    isDarkMode: _isSelectedHome(),
                    onPress: () async {
                      if (_controller.status == AnimationStatus.completed) {
                        await _controller.reverse();
                        setState(() {});
                      } else {
                        await _controller.forward();
                        setState(() {});
                      }
                    })
              ],
            )
          ]),
        ),
      ),
    );
  }

  void chagePage(int index) {
    setState(() => _selectedIndex = index);
    reelsPagingManager.setReelsDisplayed(isSelectedReelsTab());
  }

  void pickImages() {
    FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true)
        .then((result) {
      if (result?.files != null) {
        final images = result!.files;

        List<File> imageFiles =
            images.map((image) => File(image.path!)).toList();

        goFeedUpload(FeedUploadArgs(images: imageFiles));
      }
    });
  }

  void goFeedUpload(FeedUploadArgs args) {
    List<File> imageFiles =
        args.images.map((image) => File(image.path)).toList();

    List<FileImage> imageProviders =
        imageFiles.map((imageFile) => FileImage(imageFile)).toList();

    checkImageByViewPhotoPage(
            ViewPhotoArgs(imageProviders: imageProviders, checkComplete: true))
        .then((isComplete) {
      if (isComplete == true) {
        Navigator.pushNamed(context, Routes.feedUpload,
            arguments: FeedUploadArgs(images: imageFiles));
      }
    });
  }

  Future<bool?> checkImageByViewPhotoPage(ViewPhotoArgs args) {
    return Navigator.pushNamed(context, Routes.viewPhoto, arguments: args)
        .then((value) => value as bool?);
  }

  bool _isSelectedHome() {
    return _selectedIndex == 0;
  }

  bool _isSelectedSearch() {
    return _selectedIndex == 1;
  }

  bool _isSelectedMypage() {
    return _selectedIndex == 2;
  }

  bool isSelectedReelsTab() {
    return _selectedIndex == 0;
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: "뒤로가기를 한 번 더 누르면 종료됩니다");
      return Future.value(false);
    }
    return Future.value(true);
  }

  bool isFrontCamera(CameraDescription camera) {
    return camera.lensDirection == CameraLensDirection.front;
  }

  bool isBackCamera(CameraDescription camera) {
    return camera.lensDirection == CameraLensDirection.back;
  }

  Future<bool> existsArea() async {
    try {
      final response = await getIt<ApiProfile>().myAreaExists();
      return response.result.exists;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }
}
