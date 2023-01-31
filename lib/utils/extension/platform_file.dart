import 'dart:io';

import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../routes/routes.dart';

extension PlatformFileExtension on PlatformFile {
  File file() {
    return File(path!);
  }

  Image image() {
    return Image.file(
      File(path!),
      fit: BoxFit.cover,
    );
  }

  Widget imageShowable(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.viewPhoto,
          arguments: ViewPhotoArgs(imageProviders: [FileImage(file())])),
      child: image(),
    );
  }
}
