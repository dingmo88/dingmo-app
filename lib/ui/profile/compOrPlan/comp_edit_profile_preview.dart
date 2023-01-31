import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:dingmo/ui/profile/compOrPlan/forms/comp_edit_profile_form.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/consulting_button.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../utils/time/time_utils.dart';
import 'items/picto_item.dart';
import 'widgets/comp_preview_tab.dart';
import 'widgets/comp_preview_image.dart';
import '../widgets/profile_image.dart';

class CompEditProfilePreviewPage extends StatefulWidget {
  final CompEditProfileForm form;

  const CompEditProfilePreviewPage({Key? key, required this.form})
      : super(key: key);

  @override
  State<CompEditProfilePreviewPage> createState() =>
      _CompEditProfilePreviewPageState();
}

class _CompEditProfilePreviewPageState extends State<CompEditProfilePreviewPage>
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
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBars.defaultAppBar(context,
                    title: "미리보기",
                    closeEnabled: !_isLoading,
                    action: GestureDetector(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });

                        if (widget.form.getNewPictoCnt() >= 3) {
                          Fluttertoast.showToast(
                              msg: "신규 사진 등록으로 최대 몇 분 소요될 수 있습니다",
                              toastLength: Toast.LENGTH_LONG);
                        }

                        try {
                          final request = await widget.form.makeRequest();

                          print("debug! request: ${request.toJson()}");

                          await getIt<ApiProfileComp>().updateForm(request);

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
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 30, left: 30),
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
                    Row(
                      children: [
                        CompEditPreviewImageMain(picto: _getMainPicto(1)),
                        const SizedBox(width: 6),
                        Column(children: [
                          CompEditPreviewImageSub(picto: _getMainPicto(2)),
                          const SizedBox(height: 5),
                          CompEditPreviewImageSub(picto: _getMainPicto(3)),
                          const SizedBox(height: 5),
                          Stack(children: [
                            CompEditPreviewImageSub(picto: _getMainPicto(4)),
                            CompEditPreviewMoreInfoButton(form: widget.form)
                          ]),
                        ])
                      ],
                    ),
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
                    widget.form.consultAllow == true
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
            ],
          )),
    );
  }

  PictoItem<CompProfilePictorial>? _getMainPicto(int priority) {
    final picto = widget.form.pictoImgs
        .where((e) => e.isMain == true && e.priority == priority)
        .toList();

    return picto.isEmpty ? null : picto[0];
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
