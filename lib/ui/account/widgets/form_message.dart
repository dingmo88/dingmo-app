import 'package:flutter/material.dart';

class FormMessageText extends StatelessWidget {
  final String text;
  final Color textColor;
  const FormMessageText({Key? key, required this.text, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 13, color: textColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
