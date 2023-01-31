import 'package:flutter/cupertino.dart';

class ViewPhotoArgs {
  final int initViewIdx;
  final bool checkComplete;
  final List<ImageProvider> imageProviders;

  ViewPhotoArgs({
    this.initViewIdx = 0,
    this.checkComplete = false,
    required this.imageProviders,
  });
}
