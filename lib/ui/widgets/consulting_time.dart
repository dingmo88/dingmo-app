import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/time/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';

class TimeSelectionWidget extends StatefulWidget {
  final String name;
  final TimeOfDay? time;
  final void Function(TimeOfDay? timeOfDay) onSelectedTime;
  const TimeSelectionWidget(
      {Key? key,
      required this.name,
      required this.time,
      required this.onSelectedTime})
      : super(key: key);

  @override
  State<TimeSelectionWidget> createState() => _TimeSelectionWidgetState();
}

class _TimeSelectionWidgetState extends State<TimeSelectionWidget> {
  final ThemeData theme = ThemeData(
      highlightColor: AppColors.mediumPink,
      shadowColor: AppColors.mediumPink,
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
          .copyWith(secondary: AppColors.mediumPink),
      primaryColor: AppColors.mediumPink,
      canvasColor: AppColors.mediumPink,
      hoverColor: AppColors.mediumPink);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();
        widget.onSelectedTime(await showRoundedTimePicker(
          theme: theme,
          context: context,
          initialTime: TimeOfDay.now(),
        ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Texts.defaultText(text: widget.name, fontSize: 13),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.veryLightPink, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Texts.defaultText(text: getTime(), fontSize: 13),
          )
        ],
      ),
    );
  }

  String getTime() {
    return widget.time == null ? "00:00" : TimeUtils.getTime(widget.time!);
  }
}
