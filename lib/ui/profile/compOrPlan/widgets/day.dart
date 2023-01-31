import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';

class DayListWidget extends StatefulWidget {
  final bool Function(int index) isSelected;
  final void Function(int index, bool value) onSelected;
  const DayListWidget(
      {Key? key, required this.isSelected, required this.onSelected})
      : super(key: key);

  @override
  State<DayListWidget> createState() => _DayListWidgetState();
}

class _DayListWidgetState extends State<DayListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) => DayItemWidget(
            name: dayNameByNum(index + 1),
            isSelected: widget.isSelected(index),
            onSelected: (value) => widget.onSelected(index, value)),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
              width: (MediaQuery.of(context).size.width -
                      DayItemWidget.dayItemSize * 7 -
                      Dimens.horizontalPadding * 2) /
                  6,
            ));
  }

  String dayNameByNum(int num) {
    switch (num) {
      case 1:
        return "월";
      case 2:
        return "화";
      case 3:
        return "수";
      case 4:
        return "목";
      case 5:
        return "금";
      case 6:
        return "토";
      case 7:
        return "일";
      default:
        return "개";
    }
  }
}

class DayItemWidget extends StatefulWidget {
  static const double dayItemSize = 28;
  final String name;
  final bool isSelected;
  final SetBoolFunc onSelected;
  const DayItemWidget(
      {Key? key,
      required this.name,
      required this.isSelected,
      required this.onSelected})
      : super(key: key);

  @override
  State<DayItemWidget> createState() => _DayItemWidgetState();
}

class _DayItemWidgetState extends State<DayItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelected(!widget.isSelected),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    widget.isSelected ? AppColors.mediumPink : AppColors.white,
                width: 1),
            borderRadius: BorderRadius.circular(99)),
        child: Text(
          widget.name,
          style: TextStyle(
              fontSize: 12,
              color: AppColors.purpleGrey,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
