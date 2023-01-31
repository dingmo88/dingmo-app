import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:dingmo/ui/widgets/description_text.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/photo_pick_up_list.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import '../../../constants/colors.dart';
import '../../widgets/buttons.dart';
import 'widgets/review_star.dart';

class ReviewWritePage extends StatefulWidget {
  const ReviewWritePage({Key? key}) : super(key: key);

  @override
  State<ReviewWritePage> createState() => _ReviewWritePageState();
}

class _ReviewWritePageState extends State<ReviewWritePage> {
  late final StreamSubscription<bool> keyboardSubscription;

  final FocusNode reviewFocusNode = FocusNode();
  final TextEditingController reviewController = TextEditingController();

  final List<FormImage<String>> reviewImages = [];

  bool isUploading = false;

  int starCount = 0;

  @override
  void initState() {
    super.initState();

    keyboardSubscription =
        KeyboardVisibilityController().onChange.listen((visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !isUploading;
      },
      child: IgnorePointer(
          ignoring: isUploading,
          child: Scaffold(
            appBar: AppBars.defaultAppBar(context,
                title: "후기 올리기",
                action: Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Buttons.textButton(
                      text: "완료",
                      onTap: isAllFilledEssentials()
                          ? () {
                              FocusScope.of(context).unfocus();

                              uploadReview().then((value) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                    "후기 등록이 완료되었습니다",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: AppColors.mediumPink,
                                ));
                              });
                            }
                          : null,
                      color: AppColors.mediumPink,
                      isEnabled: isAllFilledEssentials(),
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                )),
            body: Stack(children: [
              ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 25),
                            Row(
                              children: [
                                Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: AppColors.greyWhite,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              "https://picsum.photos/id/227/105/105",
                                          fit: BoxFit.cover,
                                          errorWidget:
                                              (context, exception, stackTrace) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              alignment: Alignment.center,
                                              child: Image.asset(
                                                "assets/dingmo.png",
                                              ),
                                            );
                                          }),
                                    )),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "우리컨벤션",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.greyishBrown,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "웨딩홀",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.purpleGrey),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Container(
                              color: AppColors.greyWhite,
                              height: 1,
                            ),
                            const SizedBox(height: 25),
                            Text(
                              "별점을 선택해주세요",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: AppColors.greyishBrown,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 25),
                            ReviewStarWidget(
                              onStarChanged: (int starCount) {
                                setState(() {
                                  this.starCount = starCount;
                                });
                              },
                            ),
                            const SizedBox(height: 30)
                          ],
                        ),
                      ),
                      Container(color: AppColors.greyWhite, height: 4),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Text(
                              "리뷰를 작성해주세요",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: AppColors.greyishBrown,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 25),
                            TextFormField(
                              focusNode: reviewFocusNode,
                              controller: reviewController,
                              onChanged: (text) => setState(() {}),
                              decoration: InputDecoration.collapsed(
                                  focusColor: Colors.red,
                                  hintText:
                                      "다른 사용자들에게 이용하면서 느꼈던 장점과\n단점을 솔직하게 알려주세요.",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.veryLightPink)),
                              maxLength: 500,
                              minLines: 5,
                              maxLines: 10,
                            )
                          ],
                        ),
                      ),
                      Container(color: AppColors.greyWhite, height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            color: AppColors.greyWhite,
                            margin: const EdgeInsets.only(left: 20, top: 25),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                            child: Text(
                              "사진 등록시 1,000P 추가 적립!",
                              style: TextStyle(
                                  fontSize: 12, color: AppColors.mediumPink),
                            ),
                          ),
                          const SizedBox(height: 10),
                          PhotoPickupListWidget<String>(
                              showPickWayImagesSheet: false,
                              onPickImages: (images) =>
                                  reviewImages.addAll(images),
                              onDeleteImage: (image) =>
                                  reviewImages.removeWhere((reviewImage) =>
                                      reviewImage.id() == image.id())),
                          const SizedBox(height: 10),
                          Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                "웨딩과 무관한 사진의 경우, 검수를 통하여 미 노출 처리됩니다.",
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.veryLightPink),
                              )),
                          const SizedBox(height: 25),
                          Container(
                            color: AppColors.greyWhite,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "후기 작성 유의사항",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.purpleGrey),
                                  ),
                                  const SizedBox(height: 15),
                                  DescriptionText(
                                    color: AppColors.purpleGrey,
                                    description:
                                        "실제 방문한 웨딩 브랜드에 대한 후기만 작성이 가능합니다.",
                                  ),
                                  const SizedBox(height: 10),
                                  DescriptionText(
                                    color: AppColors.purpleGrey,
                                    description: "후기는 한 업체당 1개의 후기만 가능합니다.",
                                  ),
                                  const SizedBox(height: 10),
                                  DescriptionText(
                                    color: AppColors.purpleGrey,
                                    description:
                                        "해당 업체와 무관한 내용이나 동일 문자의 반복 등 부적합한 내용은 삭제 될 수 있으니 유의바랍니다.",
                                  ),
                                  const SizedBox(height: 10),
                                  DescriptionText(
                                    color: AppColors.strawberry,
                                    description: "~로 인한 불이익은 딩모와 무관합니다.",
                                  )
                                ]),
                          ),
                          const SizedBox(height: 95),
                        ],
                      )
                    ],
                  ))),
              Visibility(
                  visible: isUploading,
                  child: Center(
                    child: CircularProgressIndicator(
                        color: AppColors.mediumPink, strokeWidth: 2),
                  ))
            ]),
          )),
    );
  }

  Future<void> uploadReview() {
    setState(() {
      isUploading = true;
    });
    return Future.delayed(const Duration(seconds: 2), () {});
  }

  bool isAllFilledEssentials() {
    return reviewController.text.isNotEmpty && starCount > 0;
  }
}
