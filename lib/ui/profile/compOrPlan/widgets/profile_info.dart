import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatefulWidget {
  final Widget icon;
  final String name;
  final String? description;
  final bool? expandable;
  const ProfileInfoWidget(
      {Key? key,
      required this.icon,
      required this.name,
      this.description,
      this.expandable})
      : super(key: key);

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  final ExpandableController expandableController = ExpandableController();

  final descTextStyle = TextStyle(
      fontSize: 13, color: AppColors.greyishBrown, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.icon,
        const SizedBox(width: 6),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Texts.defaultText(
              text: widget.name, fontSize: 13, color: AppColors.purpleGrey),
        ),
        descriptionWidget()
      ],
    );
  }

  Widget descriptionWidget() {
    return widget.expandable == true
        ? Flexible(
            child: GestureDetector(
            onTap: () => setState(() => expandableController.toggle()),
            child: Container(
              color: Colors.transparent,
              child: Column(
                children: [
                  ExpandablePanel(
                    controller: expandableController,
                    collapsed: Text(
                      widget.description ?? "-",
                      softWrap: true,
                      maxLines: 2,
                      style: descTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Text(
                      widget.description ?? "-",
                      softWrap: true,
                      style: descTextStyle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: expandButton(),
                  ),
                ],
              ),
            ),
          ))
        : Flexible(
            child: GestureDetector(
            onTap: () => setState(() => expandableController.toggle()),
            child: Text(
              widget.description ?? "-",
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.greyishBrown,
                  fontWeight: FontWeight.w500),
            ),
          ));
  }

  Widget expandButton() {
    return hasTextOverflow(widget.description ?? "-", descTextStyle,
            maxLines: 2, maxWidth: MediaQuery.of(context).size.width * 0.6)
        ? GestureDetector(
            onTap: () => setState(() => expandableController.toggle()),
            child: expandableController.expanded
                ? Icon(Icons.keyboard_arrow_up,
                    size: 20, color: AppColors.purpleGrey)
                : Icon(Icons.keyboard_arrow_down,
                    size: 20, color: AppColors.purpleGrey),
          )
        : Container();
  }

  bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }
}
