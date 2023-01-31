import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_profile_plan.dart';
import 'package:dingmo/api/commons/api_response.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/select_area_button.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../routes/arguments/arg_plan_edit_profile_preview.dart';
import '../../commons/items/consulting_items.dart';
import '../../widgets/consulting_time.dart';
import '../../widgets/form.dart';
import 'forms/plan_edit_profile_form.dart';
import 'widgets/day.dart';
import '../widgets/profile_image.dart';

class PlanEditProfilePage extends StatefulWidget {
  const PlanEditProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<PlanEditProfilePage> createState() => _PlanEditProfilePageState();
}

class _PlanEditProfilePageState extends State<PlanEditProfilePage> {
  late final Future<ApiResponse<GetPlanProfileFormResult>> _loadProfileFuture;

  @override
  void initState() {
    super.initState();

    try {
      _loadProfileFuture = getIt<ApiProfilePlan>().getForm();
    } catch (e) {
      safePrint("exception: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse<GetPlanProfileFormResult>>(
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
            return PlanEditProfileContent(
              data: snapshot.data!.result,
            );
          }
        });
  }
}

class PlanEditProfileContent extends StatefulWidget {
  final GetPlanProfileFormResult data;
  const PlanEditProfileContent({Key? key, required this.data})
      : super(key: key);

  @override
  State<PlanEditProfileContent> createState() => _PlanEditProfileContentState();
}

class _PlanEditProfileContentState extends State<PlanEditProfileContent> {
  final FocusNode nicknameFocus = FocusNode();
  final FocusNode introFocus = FocusNode();

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController introController = TextEditingController();

  final ThemeData theme = ThemeData(
      highlightColor: AppColors.mediumPink,
      shadowColor: AppColors.mediumPink,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: AppColors.mediumPink),
      primaryColor: AppColors.mediumPink,
      canvasColor: AppColors.mediumPink,
      hoverColor: AppColors.mediumPink);

  late final PlanEditProfileForm form;

  @override
  void initState() {
    super.initState();

    form = PlanEditProfileForm(widget.data);

    nicknameController.text = form.nickname;
    introController.text = form.intro ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.closableAppBar(context,
          title: "프로필 설정",
          action: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Navigator.pushNamed(context, Routes.planEditProfilePreview,
                      arguments: PlanEditProfilePreviewArgs(form: form))
                  .then((isOk) {
                if (isOk == true) {
                  Navigator.pop(context, true);
                }
              });
            },
            child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(right: 20),
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
      body: SingleChildScrollView(
          child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
        child: Column(children: [
          const SizedBox(height: 40),
          ProfileImageEditableWidget(
            profileImgKey: widget.data.profiImgKey,
            onImageSelected: (image) {
              setState(() => image.path != null
                  ? form.newProfileImgFile = File(image.path!)
                  : Fluttertoast.showToast(msg: "지원하지 않는 형식입니다"));
            },
          ),
          const SizedBox(height: 30),
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
          MultiLineLimitTextForm(
              focusNode: introFocus,
              name: "소개",
              controller: introController,
              maxLength: 90,
              maxLines: 4,
              onChanged: (text) => setState(() => form.setIntro(text)),
              hint: "소개 문구를 입력해주세요."),
          const SizedBox(height: 25),
          GestureDetector(
            child: Container(
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
                        child: Texts.defaultText(text: "상담 요일", fontSize: 13),
                      ),
                      const SizedBox(height: 15),
                      ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: DayItemWidget.dayItemSize,
                            maxHeight: DayItemWidget.dayItemSize,
                          ),
                          child: DayListWidget(
                            isSelected: (index) =>
                                form.containsConsultDay(Day.values[index]),
                            onSelected: (index, value) => setState(() => value
                                ? form.addConsultDay(Day.values[index])
                                : form.removeConsultDay(Day.values[index])),
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
                                    toTimeStrRaw(timeOfDay)));
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
                                    toTimeStrRaw(timeOfDay)));
                              }
                            },
                          ),
                        ],
                      )
                    ])),
          ),
          const SizedBox(height: 80),
        ]),
      )),
    );
  }

  String toTimeStrRaw(TimeOfDay timeOfDay) {
    return "${timeOfDay.hour}:${timeOfDay.minute}";
  }

  TimeOfDay toTimeOfDay(String timeStr) {
    final timeUnits = timeStr.split(":");

    return TimeOfDay(
        hour: int.parse(timeUnits[0]), minute: int.parse(timeUnits[1]));
  }
}
