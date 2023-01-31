import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/api/api_third_party.dart';
import 'package:dingmo/api/commons/api_response.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_comp_edit_picto.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/buttons.dart';
import 'package:dingmo/ui/widgets/select_area_button.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../routes/arguments/arg_comp_edit_profile_preview.dart';
import '../../commons/items/consulting_items.dart';
import '../../widgets/consulting_time.dart';
import '../../widgets/form.dart';
import 'forms/comp_edit_profile_form.dart';
import 'widgets/day.dart';
import '../widgets/profile_image.dart';

class CompEditProfilePage extends StatefulWidget {
  const CompEditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<CompEditProfilePage> createState() => _CompEditProfilePageState();
}

class _CompEditProfilePageState extends State<CompEditProfilePage> {
  late final Future<ApiResponse<GetCompProfileFormResult>> _loadProfileFuture;

  @override
  void initState() {
    super.initState();

    try {
      _loadProfileFuture = getIt<ApiProfileComp>().getForm();
    } catch (e) {
      safePrint("exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse<GetCompProfileFormResult>>(
        future: _loadProfileFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.mediumPink,
              ),
            );
          } else {
            return CompEditProfileContent(
              data: snapshot.data!.result,
            );
          }
        });
  }
}

class CompEditProfileContent extends StatefulWidget {
  final GetCompProfileFormResult data;

  const CompEditProfileContent({Key? key, required this.data})
      : super(key: key);

  @override
  State<CompEditProfileContent> createState() => _CompEditProfileContentState();
}

class _CompEditProfileContentState extends State<CompEditProfileContent> {
  final FocusNode nicknameFocus = FocusNode();
  final FocusNode introductionFocus = FocusNode();
  final FocusNode addrDetailsFocus = FocusNode();
  final FocusNode workTimeFocus = FocusNode();
  final FocusNode discountFocus = FocusNode();
  final FocusNode couponExpiredFocus = FocusNode();

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController introductionController = TextEditingController();
  final TextEditingController addrDetailsController = TextEditingController();
  final TextEditingController workTimeController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController couponExpiredController = TextEditingController();

  final ThemeData theme = ThemeData(
      highlightColor: AppColors.mediumPink,
      shadowColor: AppColors.mediumPink,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: AppColors.mediumPink),
      primaryColor: AppColors.mediumPink,
      canvasColor: AppColors.mediumPink,
      hoverColor: AppColors.mediumPink);

  late final CompEditProfileForm form;

  @override
  void initState() {
    super.initState();

    form = CompEditProfileForm(widget.data);

    nicknameController.text = form.nickname;
    introductionController.text = form.intro ?? "";
    addrDetailsController.text = form.addrDetails ?? "";
    workTimeController.text = form.workTime ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.closableAppBar(context,
          title: "프로필 설정",
          action: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(context, Routes.compEditProfilePreview,
                      arguments: CompEditProfilePreviewArgs(form: form))
                  .then((isOk) {
                if (isOk == true) {
                  Navigator.pop(context, true);
                }
              });
            },
            child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 20, right: 20),
                alignment: Alignment.center,
                child: Text(
                  "미리보기",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.mediumPink,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          )),
      body: GestureDetector(
        child: SingleChildScrollView(
            child: Column(children: [
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.horizontalPadding),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  ProfileImageEditableWidget(
                    profileImgKey: widget.data.profiImgKey,
                    onImageSelected: (image) {
                      setState(() => image.path != null
                          ? form.newProfileImgFile = File(image.path!)
                          : Fluttertoast.showToast(msg: "지원하지 않는 형식입니다"));
                    },
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.compEditPicto,
                            arguments: CompEditPictoArgs(
                                initPictos: form.pictoImgs,
                                onPictoSelected: (pictos) {
                                  for (var element in pictos) {
                                    print(
                                        "debug! element.data.imgKey: ${element.data.imgKey()}");
                                  }

                                  form.pictoImgs.clear();
                                  form.pictoImgs.addAll(pictos);
                                }));
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: AppColors.pigPink),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                            child: Text(
                          "화보 사진 관리",
                          style:
                              TextStyle(fontSize: 14, color: AppColors.pigPink),
                        )),
                      )),
                  const SizedBox(height: 25),
                  TextForm(
                      focusNode: nicknameFocus,
                      name: "업체명(닉네임)",
                      controller: nicknameController,
                      onChanged: (text) => text.isNotEmpty
                          ? setState(() => form.setNickname(text))
                          : {}),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
          const SizedBox(height: 30),
          Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimens.horizontalPadding),
              child: Column(
                children: [
                  MultiLineLimitTextForm(
                      focusNode: introductionFocus,
                      name: "소개",
                      controller: introductionController,
                      maxLength: 90,
                      maxLines: 4,
                      onChanged: (text) => setState(() => form.setIntro(text)),
                      hint: "소개 문구를 입력해주세요."),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "주소 입력",
                      style: TextStyle(
                          color: AppColors.purpleGrey,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      final result = await getAddressFromSearchPage();
                      if (result is GetSearchAddressInfo) {
                        setState(() {
                          form.setAddr(
                              addr: result.roadAddress,
                              addrX: result.x,
                              addrY: result.y);
                        });
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              left: 10, right: 60, top: 15, bottom: 15),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.veryLightPink),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            form.addr ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 14),
                          height: 50,
                          alignment: Alignment.centerRight,
                          child: Buttons.textButton(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              final result = await getAddressFromSearchPage();
                              if (result is GetSearchAddressInfo) {
                                setState(() {
                                  form.setAddr(
                                      addr: result.roadAddress,
                                      addrX: result.x,
                                      addrY: result.y);
                                });
                              }
                            },
                            width: 40,
                            text: "조회",
                            fontSize: 13,
                            color: AppColors.mediumPink,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  TextForm(
                      focusNode: addrDetailsFocus,
                      name: "상세 주소",
                      controller: addrDetailsController,
                      onChanged: form.setAddrDetails),
                  const SizedBox(height: 25),
                  TextForm(
                      focusNode: workTimeFocus,
                      name: "영업 시간",
                      hint: "ex) 매일 오전 10시~오후 7시, 매주 월요일 휴무",
                      controller: workTimeController,
                      onChanged: form.setWorkTime),
                  const SizedBox(height: 25),
                  Container(
                    color: Colors.transparent,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "활동지역",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.greyishBrown,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          SelectAreaButton(
                              initArea1: form.area?.area1Name,
                              initArea2: form.area?.area2Name,
                              onAreaSelected: form.setArea),
                        ]),
                  ),
                  const SizedBox(height: 25),
                  Divider(
                    color: AppColors.veryLightPink,
                  ),
                  const SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Texts.defaultText(
                          text: "고객상담 메시지 수신 여부",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      Transform.scale(
                        scale: 0.7,
                        child: CupertinoSwitch(
                            trackColor: AppColors.veryLightPink,
                            activeColor: AppColors.mediumPink,
                            value: form.consultAllow,
                            onChanged: (value) {
                              FocusScope.of(context).unfocus();
                              setState(() => form.setConsultAllow(value));
                            }),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  Opacity(
                    opacity: form.consultAllow ? 1 : 0.5,
                    child: IgnorePointer(
                        ignoring: !form.consultAllow,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Texts.defaultText(
                                    text: "상담 요일", fontSize: 13),
                              ),
                              const SizedBox(height: 15),
                              ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minHeight: DayItemWidget.dayItemSize,
                                    maxHeight: DayItemWidget.dayItemSize,
                                  ),
                                  child: DayListWidget(
                                    isSelected: (index) => form
                                        .containsConsultDay(Day.values[index]),
                                    onSelected: (index, value) => setState(() =>
                                        value
                                            ? form.addConsultDay(
                                                Day.values[index])
                                            : form.removeConsultDay(
                                                Day.values[index])),
                                  )),
                              const SizedBox(height: 25),
                              Texts.defaultText(text: "시간 설정", fontSize: 13),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  TimeSelectionWidget(
                                    name: "시작",
                                    time: form.consultOpenTime != null
                                        ? toTimeOfDay(form.consultOpenTime!)
                                        : null,
                                    onSelectedTime: (timeOfDay) {
                                      if (timeOfDay != null) {
                                        setState(() => form.setConsultOpenTime(
                                            toTimeStr(timeOfDay)));
                                      }
                                    },
                                  ),
                                  const SizedBox(width: 10),
                                  Text("\n~",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.greyishBrown,
                                          fontWeight: FontWeight.w500)),
                                  const SizedBox(width: 10),
                                  TimeSelectionWidget(
                                    name: "종료",
                                    time: form.consultCloseTime != null
                                        ? toTimeOfDay(form.consultCloseTime!)
                                        : null,
                                    onSelectedTime: (timeOfDay) {
                                      if (timeOfDay != null) {
                                        setState(() => form.setConsultCloseTime(
                                            toTimeStr(timeOfDay)));
                                      }
                                    },
                                  ),
                                ],
                              )
                            ])),
                  ),
                ],
              )),
          const SizedBox(height: 80),
        ])),
        onTap: () {
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  String toTimeStr(TimeOfDay timeOfDay) {
    String hour = timeOfDay.hour.toString();
    String time = timeOfDay.minute.toString();

    return "${hour.length < 2 ? "0$hour" : hour}:${time.length < 2 ? "0$time" : time}:00";
  }

  TimeOfDay toTimeOfDay(String timeStr) {
    final timeUnits = timeStr.split(":");

    return TimeOfDay(
        hour: int.parse(timeUnits[0]), minute: int.parse(timeUnits[1]));
  }

  Future<Object?> getAddressFromSearchPage() {
    return Navigator.pushNamed(context, Routes.compSearchAddress)
        .then((value) => value);
  }
}
