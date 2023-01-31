import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';

import 'texts.dart';

class Chexkbox extends StatefulWidget {
  final bool isChecked;
  final String name;
  final SetBoolFunc onChanged;

  const Chexkbox(
      {required this.isChecked,
      required this.name,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  State<Chexkbox> createState() => _ChexkboxState();
}

class _ChexkboxState extends State<Chexkbox> {
  @override
  Widget build(BuildContext context) {
    bool value = widget.isChecked;
    return GestureDetector(
        onTap: () {
          setState(() {
            value = !value;
            widget.onChanged(value);
          });
        },
        child: Container(
          color: Colors.transparent,
          padding:
              const EdgeInsets.only(left: 16, top: 16, bottom: 16, right: 32),
          child: Row(
            children: [
              Center(
                  child: InkWell(
                      child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: value ? AppColors.mediumPink : Colors.black,
                        width: 1),
                    shape: BoxShape.circle,
                    color: value ? AppColors.mediumPink : Colors.white),
                child: value
                    ? const Icon(
                        Icons.check,
                        size: 18.0,
                        color: Colors.white,
                      )
                    : const SizedBox(
                        width: 18,
                        height: 18,
                      ),
              ))),
              const SizedBox(width: 10),
              Texts.defaultText(text: widget.name, fontSize: 13)
            ],
          ),
        ));
  }
}
