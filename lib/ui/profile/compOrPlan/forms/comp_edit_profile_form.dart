import 'dart:io';

import 'package:dingmo/api/api_area.dart';
import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/third_party/aws_s3_uploader.dart';
import 'package:dingmo/ui/commons/items/consulting_items.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/picto_item.dart';

class CompEditProfileForm {
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

  late final GetCompProfileArea? _area;
  PatchCompProfileArea? _newArea;
  GetCompProfileArea? get area => _area;
  void setArea(GetAreaResult area1, GetAreaResult area2) {
    _newArea =
        PatchCompProfileArea(area1Id: area1.areaId, area2Id: area2.areaId);
  }

  late final List<CompProfilePictorial> _originPictos;
  late final List<FormImage<CompProfilePictorialMain>> mainPictoImgs;
  late final List<PictoItem<CompProfilePictorial>> pictoImgs;
  int getNewPictoCnt() => _getNewPictos().length;
  List<PictoItem<CompProfilePictorial>> _getNewPictos() =>
      pictoImgs.where((picto) => picto.data.isFile()).toList();

  String? _intro;
  bool _introEdited = false;
  String? get intro => _intro;
  void setIntro(String value) {
    _intro = value;
    _introEdited = true;
  }

  String? _addr;
  String? _addrX;
  String? _addrY;
  bool _addrEdited = false;
  String? get addr => _addr;
  void setAddr(
      {required String addr, required String addrX, required String addrY}) {
    _addr = addr;
    _addrX = addrX;
    _addrY = addrY;
    _addrEdited = true;
  }

  String? _addrDetails;
  bool _addrDetailsEdited = false;
  String? get addrDetails => _addrDetails;
  void setAddrDetails(String value) {
    _addrDetails = value;
    _addrDetailsEdited = true;
  }

  String? _workTime;
  bool _workTimeEdited = false;
  String? get workTime => _workTime;
  void setWorkTime(String value) {
    _workTime = value;
    _workTimeEdited = true;
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

  CompEditProfileForm(GetCompProfileFormResult result) {
    formKey = result.formKey;
    profileImgKey = result.profiImgKey;
    _nickname = result.nickname;
    _area = result.area;
    _consultAllow = result.consultAllow;
    _originPictos = result.pictorials ?? [];
    pictoImgs = [
      ..._originPictos.map((originOldPicto) {
        final item = FormImage<CompProfilePictorial>.from(
            originOldPicto,
            () => originOldPicto.pictoId.toString(),
            () => originOldPicto.imgKey,
            thumbKey: () => originOldPicto.thumbKey);
        return PictoItem<CompProfilePictorial>(
            item, item.item().isMain, item.item().priority);
      })
    ];
    mainPictoImgs = (result.pictorialMains ?? [])
        .map((e) => FormImage<CompProfilePictorialMain>.from(
            e, () => e.imgKey, () => e.imgKey))
        .toList();
    _intro = result.intro;
    _addr = result.addr;
    _addrDetails = result.addrDetails;
    _addrX = null;
    _addrY = null;
    _workTime = result.workTime;
    _consultDays = result.consultDays;
    _consultOpenTime = result.consultOpenTime;
    _consultCloseTime = result.consultCloseTime;
  }

  Future<PatchCompProfileRequest> makeRequest() async {
    print("debug! 1");
    final request = PatchCompProfileRequest(formKey: formKey);
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

    final newPictos = _getNewPictos();
    final deletedPictos = _originPictos
        .where((originPicto) => pictoImgs
            .where((pictoImg) => pictoImg.data.isItem())
            .map((pictoImg) => pictoImg.data.item())
            .where((picto) => picto.pictoId == originPicto.pictoId)
            .isEmpty)
        .toList();

    request.pictorialMains = [];
    final pictoMainsMap = <int, CompProfilePictorialMain>{};
    pictoImgs.where((e) => e.isMain && e.data.isItem()).forEach((e) {
      pictoMainsMap[e.priority - 1] =
          CompProfilePictorialMain(imgKey: e.data.item().imgKey);
    });

    for (var idx = 0; idx < pictoMainsMap.length; idx++) {
      request.pictorialMains!.add(pictoMainsMap[idx]!);
    }
    // pictoMainsMap.map((index, value) {
    //   print("index: $index, value: $value");
    //   // request.pictorialMains!.add(value);
    //   return MapEntry(index, value);
    // });
    // request.pictorialMains!.insert(99, CompProfilePictorialMain(imgKey: ""));
    print("debug! 2");

    request.newPictos = [];
    if (newPictos.isNotEmpty) {
      for (final newPicto in newPictos) {
        final UploadPhotoResult result =
            (await uploader.uploadPhotos([newPicto.data.file()]))[0];

        if (newPicto.isMain) {
          request.pictorialMains!.insert(newPicto.priority - 1,
              CompProfilePictorialMain(imgKey: result.imgKey));
        }

        request.newPictos!.add(NewCompProfilePictorial(
            imgKey: result.imgKey, thumbKey: result.thumbKey));
      }
    }
    print("debug! 3");

    if (deletedPictos.isNotEmpty) {
      request.deletedPictos = deletedPictos;
    }
    if (_introEdited) {
      request.intro = _intro;
    }
    if (_addrEdited) {
      request.addr = _addr;
      request.addrX = _addrX;
      request.addrY = _addrY;
    }
    if (_addrDetailsEdited) {
      request.addrDetails = _addrDetails;
    }
    if (_workTimeEdited) {
      request.workTime = _workTime;
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
