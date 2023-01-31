import 'dart:io';

class ReelsUploadArgs {
  final File videoFile;
  final Duration videoDuration;

  ReelsUploadArgs({required this.videoFile, required this.videoDuration});
}
