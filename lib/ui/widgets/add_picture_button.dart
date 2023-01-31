import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../routes/arguments/arg_view_photo.dart';
import '../../routes/routes.dart';

class AddPictureButton extends StatefulWidget {
  // 처리할 건이 많아 당장은 무시합니다. (카메라로 사진찍어 올리기)
  // final bool showPickWayImagesSheet;
  final void Function(List<File> images) onImagesSelected;
  const AddPictureButton({
    Key? key,
    required this.onImagesSelected,
    // this.showPickWayImagesSheet = false
  }) : super(key: key);

  @override
  State<AddPictureButton> createState() => _AddPictureButtonState();
}

class _AddPictureButtonState extends State<AddPictureButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // widget.showPickWayImagesSheet
        //     ? showPickWayImagesSheet()
        //     :
        pickFeedContentImages();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.veryLightPink, width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset("assets/profile/camera_icon.svg"),
          const SizedBox(height: 5),
          Texts.defaultText(text: "사진 추가", fontSize: 12)
        ]),
      ),
    );
  }

  void showPickWayImagesSheet() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Texts.defaultText(
                        text: "사진 추가",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      FilePicker.platform
                          .pickFiles(type: FileType.image, allowMultiple: true)
                          .then((result) {
                        if (result?.files != null) {
                          final images = result!.files;

                          setState(() {
                            widget.onImagesSelected(images
                                .map((image) => File(image.path!))
                                .toList());
                          });
                        }
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Texts.defaultText(
                          text: "카메라 촬영",
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      pickFeedContentImages();
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Texts.defaultText(
                          text: "갤러리에서 선택",
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Future goViewPhotoPage(ViewPhotoArgs args) {
    return Navigator.pushNamed(context, Routes.viewPhoto, arguments: args);
  }

  void pickFeedContentImages() {
    FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true)
        .then((result) {
      if (result != null) {
        widget.onImagesSelected(
            result.files.map((file) => File(file.path!)).toList());
      }
    });
  }

  bool isFrontCamera(CameraDescription camera) {
    return camera.lensDirection == CameraLensDirection.front;
  }

  bool isBackCamera(CameraDescription camera) {
    return camera.lensDirection == CameraLensDirection.back;
  }
}
