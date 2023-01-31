import 'package:dingmo/utils/typedef.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/colors.dart';

class PickVideoFromGalleryButton extends StatelessWidget {
  final void Function(PlatformFile? video) onVideoSelected;

  const PickVideoFromGalleryButton({Key? key, required this.onVideoSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickVideo,
      child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: AppColors.greyWhite,
              border: Border.all(color: AppColors.greyWhite, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/dingmo.png"),
          )),
    );
  }

  void pickVideo() {
    FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false)
        .then((result) => onVideoSelected(result?.files[0]));
  }
}

class PicksImageFromGalleryButton extends StatelessWidget {
  final void Function(List<PlatformFile>? images) onImagesSelected;

  const PicksImageFromGalleryButton({Key? key, required this.onImagesSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickImages,
      child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: AppColors.greyWhite,
              border: Border.all(color: AppColors.greyWhite, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/dingmo.png"),
          )),
    );
  }

  void pickImages() {
    FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true)
        .then((result) => onImagesSelected(result?.files));
  }
}

class CameraModeChangeButton extends StatelessWidget {
  final VoidFunc onPressed;
  const CameraModeChangeButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              border: Border.all(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                SvgPicture.asset("assets/home/make_contents/arrows_icon.svg"),
          ),
        ));
  }
}

class TakePictureButton extends StatelessWidget {
  final VoidFunc onPressed;
  const TakePictureButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Colors.white.withOpacity(0.5)),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class BottomButtonsMargin extends StatelessWidget {
  const BottomButtonsMargin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ((MediaQuery.of(context).size.width - (40 + 80 + 40)) / 4));
  }
}
