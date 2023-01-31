import 'package:file_picker/file_picker.dart';

import '../../../ui/account/signup/form/profile_form.dart';
import '../../../ui/commons/items/consulting_items.dart';

class CompProfilePreviewArgs {
  final PlatformFile? profileImage;
  final List<PlatformFile?>? images;

  final String? nickname;
  final String? introduction;
  final String? address;

  final String? workTime;

  final bool? isAllowConsulting;
  final List<Day?>? consultingDays;
  final ConsultingTime? consultingTime;

  CompProfilePreviewArgs(
      {required this.profileImage,
      required this.images,
      required this.nickname,
      required this.introduction,
      required this.address,
      required this.workTime,
      required this.isAllowConsulting,
      required this.consultingDays,
      required this.consultingTime});

  factory CompProfilePreviewArgs.fromForm(CompProfileForm form) =>
      CompProfilePreviewArgs(
          profileImage: form.profileImage,
          images: form.images,
          nickname: form.nickname,
          introduction: form.introduction,
          address: form.address,
          workTime: form.workTime,
          isAllowConsulting: form.isAllowConsulting,
          consultingDays: form.consultingDays,
          consultingTime: form.consultingTime);
}
