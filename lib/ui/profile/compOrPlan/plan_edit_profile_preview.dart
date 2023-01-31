import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_profile_plan.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/commons/items/consulting_items.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/consulting_button.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../utils/time/time_utils.dart';
import 'forms/plan_edit_profile_form.dart';
import 'widgets/comp_preview_tab.dart';
import '../widgets/profile_image.dart';
import 'widgets/profile_info.dart';

class PlanEditProfilePreviewPage extends StatefulWidget {
  final PlanEditProfileForm form;

  const PlanEditProfilePreviewPage({Key? key, required this.form})
      : super(key: key);

  @override
  State<PlanEditProfilePreviewPage> createState() =>
      _PlanEditProfilePreviewPageState();
}

class _PlanEditProfilePreviewPageState extends State<PlanEditProfilePreviewPage>
    with TickerProviderStateMixin {
  late final TabController tabController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isLoading;
      },
      child: IgnorePointer(
        ignoring: _isLoading,
        child: Stack(children: [
          Scaffold(
            appBar: AppBars.defaultAppBar(context,
                title: "미리보기",
                closeEnabled: !_isLoading,
                action: GestureDetector(
                  onTap: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    try {
                      await getIt<ApiProfilePlan>()
                          .updateForm(await widget.form.makeRequest());

                      pop();
                    } catch (e) {
                      setState(() {
                        _isLoading = false;
                      });
                      safePrint("debug! $e");
                      Fluttertoast.showToast(msg: "수정 실패");
                    }
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Text(
                      "완료",
                      style: TextStyle(
                          color: AppColors.mediumPink,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )),
            body: SingleChildScrollView(
                child: Container(
              padding: const EdgeInsets.only(
                  top: Dimens.verticalPadding,
                  left: Dimens.horizontalPadding,
                  right: Dimens.horizontalPadding),
              child: Column(children: [
                const SizedBox(height: 25),
                ProfileFormImageWidget(
                    formImage: widget.form.newProfileImgFile != null
                        ? FormImage<String>.fromFile(
                            widget.form.newProfileImgFile!,
                            () => widget.form.newProfileImgFile!.path)
                        : FormImage<String>.from(
                            widget.form.profileImgKey ?? "",
                            () => widget.form.profileImgKey ?? "",
                            () => widget.form.profileImgKey ?? "")),
                const SizedBox(height: 15),
                Texts.defaultText(
                    text: widget.form.nickname,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                const SizedBox(height: 20),
                Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.greyWhite, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          child: ProfileInfoWidget(
                            icon: SvgPicture.asset(
                              "assets/profile/ring_icon.svg",
                              color: AppColors.veryLightPink,
                            ),
                            name: "소개",
                            description: widget.form.intro?.isNotEmpty == true
                                ? widget.form.intro
                                : "-",
                            expandable: true,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: ProfileInfoWidget(
                              icon: SvgPicture.asset(
                                "assets/profile/ring_icon.svg",
                                color: AppColors.veryLightPink,
                              ),
                              name: "활동지역",
                              description: widget.form.areaDisplay,
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 20),
                            child: ProfileInfoWidget(
                              icon: SvgPicture.asset(
                                "assets/profile/ring_icon.svg",
                                color: AppColors.veryLightPink,
                              ),
                              name: "상담시간",
                              description: widget.form.consultAllow
                                  ? "${TimeUtils.toDisplayTime(widget.form.consultOpenTime)} ~ ${TimeUtils.toDisplayTime(widget.form.consultCloseTime)}"
                                  : "-",
                            )),
                      ],
                    )),
                const SizedBox(height: 20),
                widget.form.consultAllow
                    ? const ConsultingButton()
                    : const SizedBox(height: 50),
                const SizedBox(height: 10),
                const CompEditPreviewTab()
              ]),
            )),
          ),
          Visibility(
              visible: _isLoading,
              child: Container(
                color: Colors.white.withOpacity(0.8),
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.mediumPink,
                  ),
                ),
              ))
        ]),
      ),
    );
  }

  String consultText() {
    if (widget.form.consultAllow != true) {
      return "-";
    }

    if (widget.form.consultOpenTime == null ||
        widget.form.consultCloseTime == null) {
      return "-";
    }

    if (widget.form.consultDays.isEmpty) {
      return "-";
    }

    return "${widget.form.consultDays.map((e) => dayStrToDisplayStr(e)).join(", ")}\n"
        "${TimeUtils.toDisplayTime(widget.form.consultOpenTime)} ~ ${TimeUtils.toDisplayTime(widget.form.consultCloseTime)}";
  }

  void pop() {
    Fluttertoast.showToast(msg: "반영 완료!");
    Navigator.pop(context, true);
  }

  String getTime(TimeOfDay? start, TimeOfDay? end) {
    return start == null || end == null
        ? "-"
        : "${TimeUtils.getTime(start)}"
            " ~ ${TimeUtils.getTime(end)}";
  }
}
