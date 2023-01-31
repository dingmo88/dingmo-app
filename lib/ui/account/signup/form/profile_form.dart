import 'package:file_picker/file_picker.dart';

import '../../../commons/items/consulting_items.dart';

class PlanProfileForm {
  PlatformFile? profileImage;
  String? nickname;
  String? introduction;
  String? activityArea;

  bool? isAllowConsulting;
  List<Day> consultingDays = [];
  ConsultingTime consultingTime = ConsultingTime();

  bool? isAllowCoupon;
  int? discount;
  String? dateExpireCoupon;
}

class CompProfileForm {
  PlatformFile? profileImage;
  List<PlatformFile> images = [];

  String? nickname;
  String? introduction;
  String? address;
  String? workTime;

  bool? isAllowConsulting;
  List<Day> consultingDays = [];
  ConsultingTime consultingTime = ConsultingTime();

  bool? isAllowCoupon;
  int? discount;
  String? dateExpireCoupon;
}
