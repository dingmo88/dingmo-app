import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';

extension PlatformFileExtension on XFile {
  PlatformFile toPlatformFile() {
    return PlatformFile.fromMap({
      'path': path,
      'name': name,
      'bytes': readAsBytes(),
      'size': length(),
    });
  }
}
