import '../../../commons/items/consulting_items.dart';

class PlanEditProfileItem {
  final String profileUrl;
  String nickname;
  final List<String> imageUrls;

  String introduction;
  String area1;
  String area2;

  bool isAllowConsulting;
  final List<Day?> consultingDays;
  final ConsultingTime consultingTime;

  bool isAllowCoupon;
  final int? discount;
  final String? dateExpireCoupon;

  PlanEditProfileItem({
    required this.profileUrl,
    required this.nickname,
    required this.imageUrls,
    required this.introduction,
    required this.area1,
    required this.area2,
    required this.isAllowConsulting,
    required this.consultingDays,
    required this.consultingTime,
    required this.isAllowCoupon,
    required this.discount,
    required this.dateExpireCoupon,
  });
}
