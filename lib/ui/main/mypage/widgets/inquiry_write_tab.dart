import 'dart:io';

import 'package:dingmo/ui/widgets/form.dart';
import 'package:dingmo/ui/widgets/photo_pick_up_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants/colors.dart';

class InquiryWriteTab extends StatefulWidget {
  const InquiryWriteTab({Key? key}) : super(key: key);

  @override
  State<InquiryWriteTab> createState() => _InquiryWriteTabState();
}

class _InquiryWriteTabState extends State<InquiryWriteTab> {
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  ScrollController selecteImageListController = ScrollController();
  final GlobalKey lastItemKey = GlobalKey();

  final List<File> images = [];

  bool isSendingInquiry = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(children: [
        IgnorePointer(
          ignoring: isSendingInquiry,
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    TextForm(
                        focusNode: titleFocusNode,
                        name: "제목",
                        hint: "제목을 입력해주세요.",
                        controller: titleController,
                        onChanged: (text) => setState(() {})),
                    const SizedBox(height: 25),
                    MultiLineLimitTextForm(
                      focusNode: contentFocusNode,
                      name: "내용",
                      hint: "내용을 입력해주세요.",
                      controller: contentController,
                      onChanged: (text) => setState(() {}),
                      maxLength: 500,
                      maxLines: 5,
                    ),
                    Text(
                      "사진 첨부",
                      style: TextStyle(
                          color: AppColors.greyishBrown,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ]),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: PhotoPickupListWidget<String>(
                  onPickImages: (pickedImages) => images.addAll(
                      pickedImages.map((pickedImage) => pickedImage.file())),
                  onDeleteImage: (deletedImage) => images.removeWhere(
                      (image) => image.path == deletedImage.file().path),
                )),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                  onPressed: isAllFilledEssential()
                      ? () {
                          setState(() {
                            isSendingInquiry = true;
                          });
                          sendInquiry().then((value) {
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: "문의가 등록되었습니다.");
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.mediumPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: const Center(
                        child: Text(
                      "보내기",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
                  )),
            )
          ]),
        ),
        Visibility(
            visible: isSendingInquiry,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.white.withOpacity(0.6),
              padding: const EdgeInsets.only(top: 200),
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                color: AppColors.mediumPink,
                strokeWidth: 2,
              ),
            ))
      ]),
    );
  }

  Future<void> sendInquiry() {
    return Future.delayed(const Duration(seconds: 1), () {});
  }

  bool isAllFilledEssential() {
    return titleController.text.isNotEmpty && contentController.text.isNotEmpty;
  }
}
