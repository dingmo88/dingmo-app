import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String description;
  final Color color;
  const DescriptionText(
      {Key? key, required this.description, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "- ",
        style: TextStyle(fontSize: 12, color: color),
      ),
      Flexible(
        child: Text(
          description,
          style: TextStyle(fontSize: 12, color: color, height: 1.2),
        ),
      )
    ]);
  }
}

class RichDescriptionText extends StatelessWidget {
  final RichText description;
  final Color color;
  const RichDescriptionText(
      {Key? key, required this.description, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "- ",
        style: TextStyle(fontSize: 12, color: color),
      ),
      Flexible(
        child: description,
      )
    ]);
  }
}
