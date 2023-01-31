import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';

class ProfileImageEditableWidget extends StatefulWidget {
  final String? profileImgKey;
  final void Function(PlatformFile image) onImageSelected;
  const ProfileImageEditableWidget({
    Key? key,
    this.profileImgKey,
    required this.onImageSelected,
  }) : super(key: key);

  @override
  State<ProfileImageEditableWidget> createState() =>
      _ProfileImageEditableWidgetState();
}

class _ProfileImageEditableWidgetState
    extends State<ProfileImageEditableWidget> {
  PlatformFile? selectedImgFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        pickProfileImage().then((imgFile) {
          if (imgFile != null) {
            if (imgFile.path == null) {
              Fluttertoast.showToast(msg: "지원하지 않는 파일형식입니다");
            } else {
              setState(() {
                selectedImgFile = imgFile;
              });
              widget.onImageSelected(imgFile);
            }
          }
        });
      },
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          children: [
            Center(
                child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppColors.greyWhite,
                        border:
                            Border.all(color: AppColors.greyWhite, width: 1),
                        borderRadius: BorderRadius.circular(40)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: selectedImgFile?.path != null
                          ? Image.file(
                              File(selectedImgFile!.path!),
                              fit: BoxFit.cover,
                            )
                          : (widget.profileImgKey != null
                              ? CachedNetworkImage(
                                  imageUrl: join(
                                      Endpoints.imgUrl, widget.profileImgKey!),
                                  errorWidget:
                                      (context, exception, stackTrace) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        "assets/dingmo.png",
                                      ),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/dingmo.png",
                                  ),
                                )),
                    ))),
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

class ProfileFormImageWidget extends StatefulWidget {
  final FormImage<String>? formImage;

  const ProfileFormImageWidget({Key? key, required this.formImage})
      : super(key: key);

  @override
  State<ProfileFormImageWidget> createState() => _ProfileFormImageWidgetState();
}

class _ProfileFormImageWidgetState extends State<ProfileFormImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.16,
            height: MediaQuery.of(context).size.width * 0.16,
            decoration: BoxDecoration(
                color: AppColors.greyWhite,
                border: Border.all(color: AppColors.greyWhite, width: 1),
                borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: widget.formImage != null
                  ? (widget.formImage!.isItem()
                      ? CachedNetworkImage(
                          imageUrl: join(
                              Endpoints.imgUrl, widget.formImage!.imgKey()),
                          errorWidget: (context, exception, stackTrace) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/dingmo.png",
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          widget.formImage!.file(),
                          errorBuilder: (context, exception, stackTrace) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/dingmo.png",
                              ),
                            );
                          },
                          fit: BoxFit.cover,
                        ))
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/dingmo.png",
                      ),
                    ),
            )));
  }
}

class ProfileImageWidget extends StatefulWidget {
  final String? profileImgKey;

  const ProfileImageWidget({Key? key, required this.profileImgKey})
      : super(key: key);

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            width: MediaQuery.of(context).size.width * 0.16,
            height: MediaQuery.of(context).size.width * 0.16,
            decoration: BoxDecoration(
                color: AppColors.greyWhite,
                border: Border.all(color: AppColors.greyWhite, width: 1),
                borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: widget.profileImgKey != null
                  ? CachedNetworkImage(
                      imageUrl: join(Endpoints.imgUrl, widget.profileImgKey!),
                      errorWidget: (context, exception, stackTrace) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/dingmo.png",
                          ),
                        );
                      },
                      fit: BoxFit.cover,
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/dingmo.png",
                      ),
                    ),
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
      width: MediaQuery.of(context).size.width * 0.16,
      height: MediaQuery.of(context).size.width * 0.16,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColors.greyWhite,
          border: Border.all(color: AppColors.greyWhite, width: 1),
          borderRadius: BorderRadius.circular(25)),
      child: Center(
          child:
              Image.asset("assets/dingmo.png", color: AppColors.veryLightPink)),
    );
  }
}

Future<PlatformFile?> pickProfileImage() async {
  final result = await FilePicker.platform
      .pickFiles(type: FileType.image, allowMultiple: false);

  return result?.files[0];
}
