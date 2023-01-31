import 'package:flutter/material.dart';

class SquareFittedBox extends StatelessWidget {
  final Widget child;
  const SquareFittedBox({Key? key, required this.child}) : super(key: key);

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
                    height: MediaQuery.of(context).size.width, child: child))));
  }
}
