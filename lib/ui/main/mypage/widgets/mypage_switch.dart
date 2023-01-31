import 'package:flutter/cupertino.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/texts.dart';

class MyPageSwitch extends StatefulWidget {
  final String name;
  final bool isOn;
  const MyPageSwitch({Key? key, required this.name, required this.isOn})
      : super(key: key);

  @override
  State<MyPageSwitch> createState() => _MyPageSwitchState();
}

class _MyPageSwitchState extends State<MyPageSwitch> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.isOn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, right: 5, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Texts.defaultText(
              text: widget.name, fontSize: 14, fontWeight: FontWeight.w500),
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
                trackColor: AppColors.veryLightPink,
                activeColor: AppColors.mediumPink,
                value: isOn,
                onChanged: (value) {
                  FocusScope.of(context).unfocus();
                  setState(() => isOn = value);
                }),
          )
        ],
      ),
    );
  }
}
