import '../../../commons/items/consulting_items.dart';

class CompEditProfileItem {
  final String profileUrl;
  String nickname;
  final List<String> imageUrls;

  String introduction;
  final String area1;
  final String area2;

  bool isAllowConsulting;
  final List<Day?> consultingDays;
  final ConsultingTime consultingTime;

  final bool isAllowCoupon;
  final int discount;
  final String dateExpireCoupon;

  CompEditProfileItem({
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
