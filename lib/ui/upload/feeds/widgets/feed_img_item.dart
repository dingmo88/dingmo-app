import 'dart:io';

import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedImgItemWidget extends StatefulWidget {
  final File image;
  final void Function() onDeleted;

  const FeedImgItemWidget(
      {Key? key, required this.image, required this.onDeleted})
      : super(key: key);

  @override
  State<FeedImgItemWidget> createState() => _FeedImgItemWidgetState();
}

class _FeedImgItemWidgetState extends State<FeedImgItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 88,
      child: Stack(children: [
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(right: 8, top: 8),
          decoration: BoxDecoration(
              color: AppColors.greyWhite,
              border: Border.all(color: AppColors.veryLightPink, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(widget.image), fit: BoxFit.cover)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () => widget.onDeleted(),
              child: Container(
                padding: const EdgeInsets.all(7.6),
                decoration: BoxDecoration(
                    color: AppColors.greyishBrown,
                    border:
                        Border.all(color: AppColors.veryLightPink, width: 1),
                    borderRadius: BorderRadius.circular(40)),
                child: SvgPicture.asset("assets/profile/close_icon.svg"),
              )),
        )
      ]),
    );
  }
}
