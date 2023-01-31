import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:path/path.dart';

enum VideoVaildState {
  ok,
  invalidVideo,
  invalidRatio,
  overDuration,
}

class MediaUtil {
  Future<VideoVaildState> validateVideo(String videoPath) async {
    final videoData = await getIt<FlutterVideoInfo>().getVideoInfo(videoPath);

    if (videoData == null ||
        videoData.duration == null ||
        videoData.orientation == null ||
        videoData.width == null ||
        videoData.height == null) {
      safePrint("invalid video.");
      return VideoVaildState.invalidVideo;
    }

    if ((videoData.orientation!.abs() != 90 &&
            videoData.orientation!.abs() != 270) &&
        videoData.width! > videoData.height!) {
      safePrint("invalid video ratio.");
      return VideoVaildState.invalidRatio;
    }

    if (videoData.duration! > 15 * 1000) {
      safePrint("video duration must not be over 15 seconds.");
      return VideoVaildState.overDuration;
    }

    return VideoVaildState.ok;
  }

  Future<File?> getInverted(String mediaPath) async {
    final dir = dirname(mediaPath);
    final filename = basenameWithoutExtension(mediaPath);
    final fileExt = extension(mediaPath);
    final newMediaPath = "$dir/$filename${"_inverted"}$fileExt";
    final command = "-i $mediaPath -vf hflip -c:a copy $newMediaPath";

    safePrint(command);

    final isSucceed = await FFmpegKit.execute(command).then((session) {
      session.getAllLogs().then((logs) {
        for (final log in logs) {
          safePrint("debug! ${log.getMessage()}");
        }
      });

      return session.getReturnCode();
    }).then((returnCode) => ReturnCode.isSuccess(returnCode));

    return isSucceed ? File(newMediaPath) : null;
  }
}
