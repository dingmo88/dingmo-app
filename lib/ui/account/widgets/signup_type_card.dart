import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpTypeCard extends StatefulWidget {
  final String name;
  final String? description;
  final bool isSelected;
  final SetBoolFunc onSelected;

  const SignUpTypeCard(
      {Key? key,
      required this.name,
      this.description,
      required this.isSelected,
      required this.onSelected})
      : super(key: key);

  @override
  State<SignUpTypeCard> createState() => _SignUpTypeCardState();
}

class _SignUpTypeCardState extends State<SignUpTypeCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelected(!widget.isSelected),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.isSelected
                        ? AppColors.mediumPink
                        : AppColors.greyishBrown,
                    width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.description != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Texts.defaultText(
                                  text: widget.name, fontSize: 14),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.description!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12,
                                    height: 1.2,
                                    color: AppColors.veryLightPink,
                                    fontWeight: FontWeight.w500),
                              ),
                            ])
                      : Texts.defaultText(text: widget.name, fontSize: 14),
                  Visibility(
                      visible: widget.isSelected,
                      child: SvgPicture.asset("assets/sign/check_icon.svg"))
                ]),
          ),
        ],
      ),
    );
  }
}
