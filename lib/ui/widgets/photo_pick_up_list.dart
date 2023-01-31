import 'dart:io';

import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:dingmo/ui/widgets/photo_picked_up_item.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'add_picture_button.dart';

class PhotoPickupListWidget<ItemType> extends StatefulWidget {
  final bool showPickWayImagesSheet;
  final List<FormImage<ItemType>> initImages;
  final void Function(List<FormImage<ItemType>> images) onPickImages;
  final void Function(FormImage<ItemType> image) onDeleteImage;
  const PhotoPickupListWidget({
    Key? key,
    this.showPickWayImagesSheet = false,
    this.initImages = const [],
    required this.onPickImages,
    required this.onDeleteImage,
  }) : super(key: key);

  @override
  State<PhotoPickupListWidget<ItemType>> createState() =>
      _PhotoPickupListWidgetState<ItemType>();
}

class _PhotoPickupListWidgetState<ItemType>
    extends State<PhotoPickupListWidget<ItemType>> {
  ScrollController selectedImgsController = ScrollController();
  final GlobalKey lastItemKey = GlobalKey();

  final List<FormImage<ItemType>> images = [];

  @override
  void initState() {
    super.initState();

    images.addAll(widget.initImages);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ScrollConfiguration(
        behavior: NoGlowBehavior(),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          controller: selectedImgsController,
          itemCount: images.length + 1,
          itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.only(right: 15),
              child: index == 0
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: AddPictureButton(
                          // 처리할 건이 많아 당장은 무시합니다. (카메라로 사진찍어 올리기)
                          // showPickWayImagesSheet: widget.showPickWayImagesSheet,
                          onImagesSelected: (images) {
                        checkImageByPhotoPage(ViewPhotoArgs(
                                imageProviders: images
                                    .map((image) => FileImage(image))
                                    .toList(),
                                checkComplete: true))
                            .then((isComplete) {
                          if (isComplete == true) {
                            applyNewSelectedImages(images);
                          }
                        });
                      }),
                    )
                  : PhotoPickedUpItemWidget(
                      key: index >= images.length ? lastItemKey : null,
                      image: images[index - 1],
                      onDeleted: () {
                        if (images.length > 1) {
                          setState(() =>
                              widget.onDeleteImage(images.removeAt(index - 1)));
                        } else {
                          Fluttertoast.showToast(msg: "최소 1장의 이미지를 선택해야 합니다");
                        }
                      },
                    )),
        ),
      ),
    );
  }

  Future<bool?> checkImageByPhotoPage(ViewPhotoArgs args) {
    return Navigator.pushNamed(context, Routes.viewPhoto, arguments: args)
        .then((value) => value as bool?);
  }

  void applyNewSelectedImages(List<File> pickedImages) {
    final pickedFormImages = pickedImages
        .map((pickedImage) =>
            FormImage<ItemType>.fromFile(pickedImage, () => pickedImage.path))
        .toList();

    setState(() {
      images.addAll(pickedFormImages);
    });

    /** immature function, coming soon */
    // if (lastItemKey.currentContext != null) {
    //   selecteImageListController
    //       .animateTo(selecteImageListController.position.maxScrollExtent,
    //           duration: const Duration(milliseconds: 300), curve: Curves.ease)
    //       .then((_) => Scrollable.ensureVisible(lastItemKey.currentContext!));
    // }

    widget.onPickImages(pickedFormImages);
  }
}
