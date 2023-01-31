import '../../../commons/items/consulting_items.dart';

class CompProfileMoreInfoItem {
  final List<String> imageUrls;

  final String nickname;
  final String introduction;
  final String address;

  final String workTime;

  final bool isAllowConsulting;
  final List<Day?> consultingDays;
  final ConsultingTime consultingTime;

  CompProfileMoreInfoItem({
    required this.imageUrls,
    required this.nickname,
    required this.introduction,
    required this.address,
    required this.workTime,
    required this.isAllowConsulting,
    required this.consultingDays,
    required this.consultingTime,
  });
}
