import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  final Widget child;
  final String dateSent;
  const MyMessage({Key? key, required this.child, required this.dateSent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
          margin: const EdgeInsets.only(bottom: 15, left: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dateSent,
                  style:
                      TextStyle(fontSize: 12, color: AppColors.veryLightPink),
                ),
                const SizedBox(width: 5),
                Flexible(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomLeft: Radius.circular(24),
                    ),
                    border: Border.all(width: 1, color: AppColors.greyishPink),
                  ),
                  child: child,
                )),
              ])),
    );
  }
}

class YourMessage extends StatelessWidget {
  final Widget child;
  final String dateSent;
  const YourMessage({Key? key, required this.child, required this.dateSent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.only(bottom: 15, right: 15),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    border: Border.all(width: 1, color: AppColors.greyishPink),
                  ),
                  child: child,
                )),
                const SizedBox(width: 5),
                Text(
                  dateSent,
                  style:
                      TextStyle(fontSize: 12, color: AppColors.veryLightPink),
                ),
              ])),
    );
  }
}
