import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/arguments/arg_comp_edit_preview_moreinfo.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/picto_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';

import '../forms/comp_edit_profile_form.dart';

int randomNum(int min, int max) => min + Random().nextInt(max - min);

class CompEditPreviewImageSub extends StatefulWidget {
  final PictoItem<CompProfilePictorial>? picto;

  const CompEditPreviewImageSub({Key? key, required this.picto})
      : super(key: key);

  @override
  State<CompEditPreviewImageSub> createState() =>
      _CompEditPreviewImageSubState();
}

class CompEditPreviewImageMain extends StatefulWidget {
  final PictoItem<CompProfilePictorial>? picto;

  const CompEditPreviewImageMain({Key? key, required this.picto})
      : super(key: key);

  @override
  State<CompEditPreviewImageMain> createState() =>
      _CompEditPreviewImageMainState();
}

class CompEditPreviewMoreInfoButton extends StatefulWidget {
  final CompEditProfileForm form;
  const CompEditPreviewMoreInfoButton({Key? key, required this.form})
      : super(key: key);

  @override
  State<CompEditPreviewMoreInfoButton> createState() =>
      _CompEditPreviewMoreInfoButtonState();
}

class _CompEditPreviewImageMainState extends State<CompEditPreviewImageMain> {
  @override
  Widget build(BuildContext context) {
    final sizeElement = MediaQuery.of(context).size.width * 0.211;
    final size = sizeElement * 3 + 5 * 2;

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
          width: size,
          height: size,
          color: AppColors.greyWhite,
          child: widget.picto != null
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.mediumPink,
                    )),
                    (widget.picto!.data.isItem()
                        ? CachedNetworkImage(
                            imageUrl: join(Endpoints.imgUrl,
                                widget.picto!.data.item().imgKey),
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            widget.picto!.data.file(),
                            fit: BoxFit.cover,
                          ))
                  ],
                )
              : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset("assets/profile/gallery_icon.svg"),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "아직 화보 사진이 없어요",
                    style:
                        TextStyle(fontSize: 12, color: AppColors.veryLightPink),
                  )
                ])),
    );
  }
}

class _CompEditPreviewImageSubState extends State<CompEditPreviewImageSub> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.211;

    return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
            color: AppColors.greyWhite,
            width: size,
            height: size,
            child: widget.picto != null
                ? Stack(
                    fit: StackFit.expand,
                    children: [
                      Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.mediumPink,
                      )),
                      (widget.picto!.data.isItem()
                          ? CachedNetworkImage(
                              imageUrl: join(Endpoints.imgUrl,
                                  widget.picto!.data.item().imgKey),
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              widget.picto!.data.file(),
                              fit: BoxFit.cover,
                            ))
                    ],
                  )
                : Container()));
  }
}

class _CompEditPreviewMoreInfoButtonState
    extends State<CompEditPreviewMoreInfoButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.211;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.compEditPreviewMoreInfo,
            arguments: CompEditProfilePreviewMoreInfoArgs(form: widget.form));
      },
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
