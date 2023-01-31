import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeCategoryButton extends StatelessWidget {
  final String assetUrl;
  final String name;
  final void Function() onPressed;
  const HomeCategoryButton(
      {Key? key,
      required this.onPressed,
      required this.assetUrl,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          color: Colors.transparent,
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * 0.144,
                  height: MediaQuery.of(context).size.width * 0.144,
                  decoration: BoxDecoration(
                    color: const Color(0xfff8f8f8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(assetUrl, width: 20)),
              const SizedBox(height: 7),
              Text(
                name,
                style: TextStyle(
                    fontSize: 13,
                    color: AppColors.purpleGrey,
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
    );
  }
}
