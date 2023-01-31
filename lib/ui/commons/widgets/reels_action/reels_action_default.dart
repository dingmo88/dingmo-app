import 'package:dingmo/ui/commons/widgets/reels_action/reels_uploader_info_default.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/typedef.dart';
import 'reels_button_like_default.dart';

class ReelsActionDefaultWidget extends StatefulWidget {
  const ReelsActionDefaultWidget({Key? key}) : super(key: key);

  @override
  State<ReelsActionDefaultWidget> createState() =>
      _ReelsActionDefaultWidgetState();
}

class _ReelsActionDefaultWidgetState extends State<ReelsActionDefaultWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                )),
            Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                    ],
                    stops: const [0.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                )),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ReelsUploaderInfoDefaultWidget(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ReelsCameraButton(),
                  const Spacer(),
                  Column(
                    children: [
                      iconButton("assets/home/sound_on_icon.svg", () {}),
                      const SizedBox(height: 15),
                      const ReelsLikeButtonDefault(),
                      Texts.defaultText(
                          text: "0",
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 25),
                      iconButton("assets/home/message_icon.svg", () {}),
                      const SizedBox(height: 5),
                      Texts.defaultText(
                          text: "0",
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 25),
                      iconButton("assets/home/bookmark_off_icon.svg", () {
                        setState(() {});
                      }),
                      const SizedBox(height: 5),
                      Texts.defaultText(
                          text: "0",
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 25),
                      iconButton("assets/home/share_icon.svg", () {}),
                      const SizedBox(height: 5),
                      Texts.defaultText(
                          text: "0",
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 25),
                      iconButton("assets/home/dots_icon.svg", () {}),
                      const SizedBox(height: 30),
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }

  Widget iconButton(String assetDir, VoidFunc onTap, {Color? color}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 50.0,
                  spreadRadius: 20.0,
                )
              ],
            ),
            child: SvgPicture.asset(
              assetDir,
            )));
  }

  Widget iconButton2(IconData iconData, VoidFunc onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 50.0,
                  spreadRadius: 20.0,
                )
              ],
            ),
            child: Icon(
              iconData,
              color: Colors.white,
            )));
  }
}
