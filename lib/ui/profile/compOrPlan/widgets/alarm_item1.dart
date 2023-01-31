import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_divider.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/alarm_item.dart';
import 'package:dingmo/ui/profile/compOrPlan/widgets/alarm_item2.dart';
import 'package:flutter/material.dart';

class AlarmItem1Widget extends StatelessWidget {
  final AlarmItem1 item;
  const AlarmItem1Widget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Text(
            item.dateTitle,
            style: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
          ),
        ),
        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) =>
                AlarmItem2Widget(item: item.items[index]),
            separatorBuilder: (context, index) => const MyPageDivider(),
            itemCount: item.items.length)
      ]),
    );
  }
}
