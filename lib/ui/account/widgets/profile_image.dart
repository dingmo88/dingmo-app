import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/utils/extension/platform_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImageEditableWidget extends StatefulWidget {
  final PlatformFile? image;
  final void Function(PlatformFile image) onImageSelected;
  const ProfileImageEditableWidget(
      {Key? key, this.image, required this.onImageSelected})
      : super(key: key);

  @override
  State<ProfileImageEditableWidget> createState() =>
      _ProfileImageEditableWidgetState();
}

class _ProfileImageEditableWidgetState
    extends State<ProfileImageEditableWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        pickProfileImage().then((result) {
          if (result != null) {
            widget.onImageSelected(result.files[0]);
          }
        });
      },
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          children: [
            widget.image != null
                ? ProfileImageWidget(image: widget.image, showable: false)
                : const DefaultProfileWidget(),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 28,
                height: 28,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.greyWhite, width: 1),
                    borderRadius: BorderRadius.circular(30)),
                child: SvgPicture.asset("assets/profile/pencil_icon.svg"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileImageWidget extends StatefulWidget {
  final PlatformFile? image;
  final bool showable;

  const ProfileImageWidget(
      {Key? key, required this.image, this.showable = true})
      : super(key: key);

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: AppColors.greyWhite,
                border: Border.all(color: AppColors.greyWhite, width: 1),
                borderRadius: BorderRadius.circular(30)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: widget.showable
                  ? widget.image?.imageShowable(context)
                  : widget.image?.image(),
            )));
  }
}

class DefaultProfileWidget extends StatefulWidget {
  const DefaultProfileWidget({Key? key}) : super(key: key);

  @override
  State<DefaultProfileWidget> createState() => _DefaultProfileWidgetState();
}

class _DefaultProfileWidgetState extends State<DefaultProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: AppColors.greyWhite,
          border: Border.all(color: AppColors.greyWhite, width: 1),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
          child:
              Image.asset("assets/dingmo.png", color: AppColors.veryLightPink)),
    );
  }
}

Future<FilePickerResult?> pickProfileImage() async {
  return FilePicker.platform
      .pickFiles(type: FileType.image, allowMultiple: false);
}
