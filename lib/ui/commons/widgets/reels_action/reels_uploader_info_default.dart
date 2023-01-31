import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';

class ReelsUploaderInfoDefaultWidget extends StatefulWidget {
  const ReelsUploaderInfoDefaultWidget({Key? key}) : super(key: key);

  @override
  State<ReelsUploaderInfoDefaultWidget> createState() =>
      _ReelsUploaderInfoDefaultWidgetState();
}

class _ReelsUploaderInfoDefaultWidgetState
    extends State<ReelsUploaderInfoDefaultWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        Row(
          children: [
            Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: AppColors.greyWhite,
                    border: Border.all(color: AppColors.greyWhite, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                )),
            const SizedBox(
              width: 10,
            ),
            Texts.defaultText(
                text: "",
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.normal),
            const Icon(
              Icons.keyboard_arrow_right_outlined,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
        const SizedBox(height: 10),
        Texts.defaultText(
            text: "",
            fontSize: 13,
            color: Colors.white,
            fontWeight: FontWeight.normal),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "",
                  softWrap: true,
                  maxLines: 1,
                  style:
                      TextStyle(fontSize: 13, color: Colors.white, height: 1.2),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 10,
                )
              ]),
        )
      ],
    );
  }
}
