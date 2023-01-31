import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/commons/items/form_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart';

class PhotoPickedUpItemWidget<ItemType> extends StatelessWidget {
  final FormImage<ItemType> image;
  final void Function() onDeleted;

  const PhotoPickedUpItemWidget(
      {Key? key, required this.image, required this.onDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      height: 88,
      child: Stack(children: [
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.only(right: 8, top: 8),
          decoration: BoxDecoration(
              color: AppColors.greyWhite,
              border: Border.all(color: AppColors.veryLightPink, width: 1),
              borderRadius: BorderRadius.circular(5)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              decoration: BoxDecoration(
                  image: image.isFile()
                      ? DecorationImage(
                          image: FileImage(image.file()), fit: BoxFit.cover)
                      : DecorationImage(
                          image: NetworkImage(join(
                              Endpoints.imgUrl,
                              image.thumbKey != null
                                  ? image.thumbKey!()
                                  : image.imgKey())),
                          fit: BoxFit.cover)),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
              onTap: () => onDeleted(),
              child: Container(
                padding: const EdgeInsets.all(7.6),
                decoration: BoxDecoration(
                    color: AppColors.greyishBrown,
                    border:
                        Border.all(color: AppColors.veryLightPink, width: 1),
                    borderRadius: BorderRadius.circular(40)),
                child: SvgPicture.asset("assets/profile/close_icon.svg"),
              )),
        )
      ]),
    );
  }
}
