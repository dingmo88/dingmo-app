import 'dart:io';

import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/colors.dart';

class InquiryImgItemWidget extends StatefulWidget {
  final File image;
  final void Function() onDeleted;

  const InquiryImgItemWidget(
      {Key? key, required this.image, required this.onDeleted})
      : super(key: key);

  @override
  State<InquiryImgItemWidget> createState() => _InquiryImgItemWidgetState();
}

class InquiryHistoryImgItemWidget extends StatefulWidget {
  final String imgUrl;

  const InquiryHistoryImgItemWidget({Key? key, required this.imgUrl})
      : super(key: key);

  @override
  State<InquiryHistoryImgItemWidget> createState() =>
      _InquiryHistoryImgItemWidgetState();
}

class _InquiryImgItemWidgetState extends State<InquiryImgItemWidget> {
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

class _InquiryHistoryImgItemWidgetState
    extends State<InquiryHistoryImgItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.viewPhoto,
          arguments:
              ViewPhotoArgs(imageProviders: [NetworkImage(widget.imgUrl)])),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            color: AppColors.veryLightPink,
            borderRadius: BorderRadius.circular(5)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.imgUrl), fit: BoxFit.cover)),
          ),
        ),
      ),
    );
  }
}
