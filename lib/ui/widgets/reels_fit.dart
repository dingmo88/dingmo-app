import 'package:flutter/material.dart';

class ReelsFittedBox extends StatelessWidget {
  final Widget child;
  final double? height;
  const ReelsFittedBox({Key? key, required this.child, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: OverflowBox(
            maxWidth: double.infinity,
            alignment: Alignment.center,
            child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: SizedBox(
                    height: height ?? MediaQuery.of(context).size.height,
                    child: child))));
  }
}
