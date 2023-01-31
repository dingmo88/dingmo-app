import 'dart:io';

class ReelsPreviewArgs {
  final File videoFile;
  final bool inverted;
  final bool isFilmed;
  Future<void>? invertingFuture;
  ReelsPreviewArgs({
    required this.videoFile,
    this.inverted = false,
    this.isFilmed = false,
  });
}
