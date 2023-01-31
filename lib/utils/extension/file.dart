import 'dart:io';

import 'package:dingmo/utils/extension/platform_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

extension FileExtension on File {
  PlatformFile platformFile() {
    return PlatformFile(path: path, name: basename(path), size: lengthSync());
  }

  bool isSameName(File file) {
    return name() == file.name();
  }

  bool isSameNamePlatformFile(PlatformFile platformFile) {
    return name() == platformFile.file().name();
  }

  String name() {
    return basename(path);
  }
}
