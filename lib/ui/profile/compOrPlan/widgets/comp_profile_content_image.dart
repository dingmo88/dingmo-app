import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/arguments/arg_comp_profile_moreinfo.dart';
import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;

int randomNum(int min, int max) => min + Random().nextInt(max - min);

class CompProfileContentImageSub extends StatefulWidget {
  final String? imgKey;

  const CompProfileContentImageSub({Key? key, required this.imgKey})
      : super(key: key);

  @override
  State<CompProfileContentImageSub> createState() =>
      _CompProfileContentImageSubState();
}

class CompProfileContentImageMain extends StatefulWidget {
  final String? imgKey;

  const CompProfileContentImageMain({Key? key, required this.imgKey})
      : super(key: key);

  @override
  State<CompProfileContentImageMain> createState() =>
      _CompProfileContentImageMainState();
}

class CompProfileMoreInfoButton extends StatelessWidget {
  final GetCompProfileResult profileInfo;
  const CompProfileMoreInfoButton({Key? key, required this.profileInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.211;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.compProfileMoreInfo,
          arguments: CompProfileMoreInfoArgs(profileInfo: profileInfo)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          alignment: Alignment.center,
          color: Colors.black.withOpacity(0.5),
          width: size,
          height: size,
          child: const Text(
            "더보기",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _CompProfileContentImageMainState
    extends State<CompProfileContentImageMain> {
  late final String? _imageUrl;

  @override
  void initState() {
    super.initState();

    _imageUrl = widget.imgKey == null
        ? null
        : path.join(Endpoints.imgUrl, widget.imgKey);
  }

  @override
  Widget build(BuildContext context) {
    final sizeElement = MediaQuery.of(context).size.width * 0.211;
    final size = sizeElement * 3 + 5 * 2;

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GestureDetector(
          onTap: () {
            if (_imageUrl != null) {
              Navigator.pushNamed(context, Routes.viewPhoto,
                  arguments: ViewPhotoArgs(
                      imageProviders: [NetworkImage(_imageUrl!)]));
            }
          },
          child: Container(
              width: size,
              height: size,
              color: AppColors.greyWhite,
              child: _imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: _imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          SvgPicture.asset("assets/profile/gallery_icon.svg"),
                          const SizedBox(
                            height: 35,
                          ),
                          Text(
                            "아직 화보 사진이 없어요",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.veryLightPink),
                          )
                        ]))),
    );
  }
}

class _CompProfileContentImageSubState
    extends State<CompProfileContentImageSub> {
  late final String? _imageUrl;

  @override
  void initState() {
    super.initState();

    _imageUrl = widget.imgKey == null
        ? null
        : path.join(Endpoints.imgUrl, widget.imgKey);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.211;

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GestureDetector(
          onTap: () {
            if (_imageUrl != null) {
              Navigator.pushNamed(context, Routes.viewPhoto,
                  arguments: ViewPhotoArgs(
                      imageProviders: [NetworkImage(_imageUrl!)]));
            }
          },
          child: Container(
            color: AppColors.greyWhite,
            width: size,
            height: size,
            child: widget.imgKey != null
                ? CachedNetworkImage(
                    imageUrl: _imageUrl!,
                    fit: BoxFit.cover,
                  )
                : Container(),
          )),
    );
  }
}
