import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants/colors.dart';

class AddPictoButton extends StatelessWidget {
  final void Function(List<File> images) onPickImages;
  const AddPictoButton({Key? key, required this.onPickImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => onPickImages(await _pickImages()),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: const Color(0xffe0e0e0))),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/home/cameraplus_icon.svg"),
            const SizedBox(height: 5),
            Text(
              "화보 추가",
              style: TextStyle(
                  fontSize: 12,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500),
            ),
          ],
        )),
      ),
    );
  }

  Future<List<File>> _pickImages() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (result?.files != null) {
      final images = result!.files;

      return images.map((image) => File(image.path!)).toList();
    }

    return [];
  }
}
