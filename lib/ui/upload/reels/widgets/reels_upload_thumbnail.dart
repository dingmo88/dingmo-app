import 'dart:io';
import 'dart:math';

import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';

int randomNum(int min, int max) => min + Random().nextInt(max - min);

class ReelsUploadThumbnail extends StatefulWidget {
  final Future<List<File>> imagesFuture;
  final int index;
  final bool isSelected;
  final VoidFunc onPressed;

  const ReelsUploadThumbnail(
      {Key? key,
      required this.imagesFuture,
      required this.index,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);

  @override
  State<ReelsUploadThumbnail> createState() => _ReelsUploadThumbnailState();
}

class _ReelsUploadThumbnailState extends State<ReelsUploadThumbnail> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.211,
        height: MediaQuery.of(context).size.width * 0.211,
        child: FutureBuilder<List<File>>(
          future: widget.imagesFuture,
          builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
            if (snapshot.hasData) {
              return GestureDetector(
                onTap: widget.onPressed,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      snapshot.data![widget.index],
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5))))),
                    Visibility(
                        visible: !widget.isSelected,
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                        )),
                  ],
                ),
              );
            } else {
              return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.greyWhite,
                        width: 2.0,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.mediumPink,
                    ),
                  ));
            }
          },
        ),
      ),
    );
  }
}
