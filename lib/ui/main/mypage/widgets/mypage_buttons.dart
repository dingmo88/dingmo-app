import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/colors.dart';

class AlarmButton extends StatefulWidget {
  final bool hasNewAlarms;
  final VoidFunc onPressed;
  const AlarmButton(
      {Key? key, required this.hasNewAlarms, required this.onPressed})
      : super(key: key);

  @override
  State<AlarmButton> createState() => _AlarmButtonState();
}

class _AlarmButtonState extends State<AlarmButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
          color: Colors.transparent,
          child: Stack(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              margin: const EdgeInsets.only(right: 18),
              child: SvgPicture.asset("assets/mypage/alarm_icon.svg"),
            ),
            Visibility(
                visible: widget.hasNewAlarms,
                child: Container(
                  width: 25,
                  height: 25,
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                        color: AppColors.mediumPink,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(99))),
                  ),
                ))
          ])),
    );
  }
}

class ProfileMenuButton extends StatelessWidget {
  final String name;
  final VoidFunc onPressed;
  final Widget icon;
  final bool? enabled;
  const ProfileMenuButton(
      {Key? key,
      required this.name,
      required this.onPressed,
      required this.icon,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 15),
              Text(
                name,
                style: TextStyle(
                    fontSize: 13,
                    color: enabled == true
                        ? AppColors.black
                        : AppColors.greyishBrown.withOpacity(0.4),
                    fontWeight: FontWeight.w500),
              ),
            ],
          )),
    );
  }
}
