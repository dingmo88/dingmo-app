import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class ReelsUpdateThumbnail extends StatefulWidget {
  final String thumbImgKey;
  final bool isSelected;
  final VoidFunc onPressed;

  const ReelsUpdateThumbnail(
      {Key? key,
      required this.thumbImgKey,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);

  @override
  State<ReelsUpdateThumbnail> createState() => _ReelsUpdateThumbnailState();
}

class _ReelsUpdateThumbnailState extends State<ReelsUpdateThumbnail> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.211,
        height: MediaQuery.of(context).size.width * 0.211,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CachedNetworkImage(
                imageUrl: join(Endpoints.imgUrl, widget.thumbImgKey),
                fit: BoxFit.cover,
              ),
              Visibility(
                  visible: widget.isSelected,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.mediumPink,
                            width: 2.0,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5))))),
              Visibility(
                  visible: !widget.isSelected,
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
