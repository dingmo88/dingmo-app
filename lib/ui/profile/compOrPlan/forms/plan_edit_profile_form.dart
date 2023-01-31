import 'dart:io';

import 'package:dingmo/api/api_area.dart';
import 'package:dingmo/api/api_profile_plan.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/third_party/aws_s3_uploader.dart';
import 'package:dingmo/ui/commons/items/consulting_items.dart';

class PlanEditProfileForm {
  late final String formKey;

  late final String? profileImgKey;
  File? newProfileImgFile;

  late String _nickname;
  bool _nicknameEdited = false;
  String get nickname => _nickname;
  void setNickname(String value) {
    _nickname = value;
    _nicknameEdited = true;
  }

  late bool _consultAllow;
  bool _consultAllowEdited = false;
  bool get consultAllow => _consultAllow;
  void setConsultAllow(bool value) {
    _consultAllow = value;
    _consultAllowEdited = true;
  }

  late final GetPlanProfileArea? _area;
  PatchPlanProfileArea? _newArea;
  String? _newAreaDisplay;
  GetPlanProfileArea? get area => _area;
  PatchPlanProfileArea? get newArea => _newArea;
  String get areaDisplay => _area == null && _newAreaDisplay == null
      ? "-"
      : (_area == null
          ? _newAreaDisplay!
          : getAreaDisplyArea(_area!.area1Name, _area!.area2Name));
  void setArea(GetAreaResult area1, GetAreaResult area2) {
    _newArea =
        PatchPlanProfileArea(area1Id: area1.areaId, area2Id: area2.areaId);
    _newAreaDisplay = getAreaDisplyArea(area1.areaName, area2.areaName);
  }

  String getAreaDisplyArea(String area1, String area2) {
    return (area1 == "서울" && area2 != "전체") ? area2 : "$area1 $area2";
  }

  String? _intro;
  bool _introEdited = false;
  String? get intro => _intro;
  void setIntro(String value) {
    _intro = value;
    _introEdited = true;
  }

  List<String>? _consultDays;
  bool _consultDaysEdited = false;
  List<String> get consultDays => _consultDays ?? [];
  bool containsConsultDay(Day day) {
    return _consultDays?.contains(dayToStr(day)) == true;
  }

  void addConsultDay(Day day) {
    _consultDays ??= [];
    _consultDays!.add(dayToStr(day));
    _consultDaysEdited = true;
  }

  void removeConsultDay(Day day) {
    if (_consultDays != null && _consultDays?.remove(dayToStr(day)) == true) {
      _consultDaysEdited = true;
    }
  }

  String? _consultOpenTime;
  bool _consultOpenTimeEdited = false;
  String? get consultOpenTime => _consultOpenTime;
  void setConsultOpenTime(String value) {
    _consultOpenTime = value;
    _consultOpenTimeEdited = true;
  }

  String? _consultCloseTime;
  bool _consultCloseTimeEdited = false;
  String? get consultCloseTime => _consultCloseTime;
  void setConsultCloseTime(String value) {
    _consultCloseTime = value;
    _consultCloseTimeEdited = true;
  }

  PlanEditProfileForm(GetPlanProfileFormResult result) {
    formKey = result.formKey;
    profileImgKey = result.profiImgKey;
    _nickname = result.nickname;
    _area = result.area;
    _consultAllow = result.consultAllow;
    _intro = result.intro;
    _consultDays = result.consultDays;
    _consultOpenTime = result.consultOpenTime;
    _consultCloseTime = result.consultCloseTime;
  }

  Future<PatchPlanProfileRequest> makeRequest() async {
    final request = PatchPlanProfileRequest(formKey: formKey);
    final uploader = getIt<AwsS3Uploader>();

    if (_nicknameEdited) {
      request.nickname = _nickname;
    }
    if (_consultAllowEdited) {
      request.consultAllow = _consultAllow;
    }

    if (newProfileImgFile != null) {
      final UploadProfileResult result =
          await uploader.uploadProfile(newProfileImgFile!);
      request.profiImgKey = result.profileKey;
    }

    if (_newArea != null) {
      request.area = _newArea;
    }

    if (_introEdited) {
      request.intro = _intro;
    }

    if (_consultDaysEdited) {
      request.consultDays = _consultDays;
    }

    if (_consultOpenTimeEdited) {
      request.consultOpenTime = _consultOpenTime;
    }

    if (_consultCloseTimeEdited) {
      request.consultCloseTime = _consultCloseTime;
    }

    return request;
  }
}
