import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:camera/camera.dart';
import 'package:dingmo/api/api_profile.dart';
import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_feed_upload.dart';
import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:dingmo/ui/widgets/light_status_bar.dart';
import 'package:dingmo/routes/arguments/args_reels_filming.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/home_banner.dart';
import 'widgets/home_body.dart';
import 'widgets/home_fab_menu.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();

  late final Future<GetHomeResult?> _getSearchHomeFuture;

  @override
  void initState() {
    super.initState();

    _getSearchHomeFuture = _getSearchHome();
  }

  Future<GetHomeResult?> _getSearchHome() async {
    try {
      return (getIt<MemberInfo>().isGuest()
              ? await getIt<ApiSearch>().getHomeGuest()
              : await getIt<ApiSearch>().getHome())
          .result;
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return LightStatusBarWidget(
        child: FutureBuilder<GetHomeResult?>(
      future: _getSearchHomeFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 150),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.mediumPink,
            ),
          );
        } else {
          final result = snapshot.data;

          if (result == null) {
            Fluttertoast.showToast(msg: "잘못된 접근입니다");
            return Container();
          }

          return Scaffold(
              body: Stack(children: [
            CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverHomeBannerDelegate(
                      bannImgKeys:
                          result.banners.map((e) => e.bannImgKey).toList()),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                      [HomeTabBodyWidget(result: result)]),
                ),
              ],
            ),
          ]));
        }
      },
    ));
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
