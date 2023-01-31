import 'dart:convert';
import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_full_gpl/return_code.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UploadPhotoResult {
  final String imgKey;
  final String thumbKey;
  UploadPhotoResult({required this.imgKey, required this.thumbKey});
}

class UploadThumbnailResult {
  final String thumbKey;
  UploadThumbnailResult({required this.thumbKey});
}

class UploadProfileResult {
  final String profileKey;
  UploadProfileResult({required this.profileKey});
}

class UploadShortsResult {
  final String m3u8Key;
  UploadShortsResult({required this.m3u8Key});
}

class AwsS3Uploader {
  final _reelsAspectRatio = 0.5625; // 9:16

  Future<UploadShortsResult?> uploadVideo(File validatedVideoFile) async {
    final resizedVideo = await _resizeVideoFile(validatedVideoFile);

    if (resizedVideo == null) {
      return null;
    }

    final presignedUploadVideo = await _getVideoPresignedInfo();

    safePrint("presignedUploadVideo: $presignedUploadVideo");

    await _uploadVideoToSignedURL(
        file: resizedVideo,
        presignedUrl: presignedUploadVideo.url,
        onSendProgress: ((sentBytes, totalBytes) =>
            safePrint("upload ${(sentBytes / totalBytes * 100).toInt()} %")));

    return UploadShortsResult(m3u8Key: presignedUploadVideo.key);
  }

  Future<UploadProfileResult> uploadProfile(File originFile) async {
    final profileImgFile = _extractProfile(originFile);

    final presignedProfile = await _getProfilePresignedInfo();

    await _uploadImageToSignedURL(
        file: (await profileImgFile)!, presignedUrl: presignedProfile.url);

    return UploadProfileResult(profileKey: presignedProfile.key);
  }

  Future<List<UploadThumbnailResult>> uploadThumbnails(
      List<File> originFiles) async {
    final thumbnailFiles =
        originFiles.map((file) => _extractThumbnail(file)).toList();

    final presignedUploadThumbs =
        await _getImgThumbPresignedInfos(publishCnt: thumbnailFiles.length);

    final imgKeys = <UploadThumbnailResult>[];

    for (var idx = 0; idx < originFiles.length; idx++) {
      await _uploadImageToSignedURL(
          file: (await thumbnailFiles[idx])!,
          presignedUrl: presignedUploadThumbs[idx].url);

      imgKeys
          .add(UploadThumbnailResult(thumbKey: presignedUploadThumbs[idx].key));
    }

    return imgKeys;
  }

  Future<List<UploadPhotoResult>> uploadPhotos(List<File> originFiles) async {
    if (originFiles.isEmpty) {
      return [];
    }

    final thumbnailFiles =
        originFiles.map((file) => _extractThumbnail(file)).toList();

    final presignedUploadImgs =
        await _getImgOriginPresignedInfos(publishCnt: originFiles.length);
    final presignedUploadThumbs =
        await _getImgThumbPresignedInfos(publishCnt: thumbnailFiles.length);

    final imgKeys = <UploadPhotoResult>[];

    for (var idx = 0; idx < originFiles.length; idx++) {
      safePrint(
          "debug! presignedUploadImgs[$idx]: ${presignedUploadImgs[idx]}, presignedUploadThumbs[$idx]: ${presignedUploadThumbs[idx]}");
      await _uploadImageToSignedURL(
          file: originFiles[idx], presignedUrl: presignedUploadImgs[idx].url);
      await _uploadImageToSignedURL(
          file: (await thumbnailFiles[idx])!,
          presignedUrl: presignedUploadThumbs[idx].url);

      imgKeys.add(UploadPhotoResult(
          imgKey: presignedUploadImgs[idx].key,
          thumbKey: presignedUploadThumbs[idx].key));
    }

    return imgKeys;
  }

  Future<List<_Presigned>> _getImgOriginPresignedInfos(
      {required int publishCnt}) async {
    return _getImagePresignedInfos(publishCnt, Endpoints.uploadPhotoPresign);
  }

  Future<List<_Presigned>> _getImgThumbPresignedInfos(
      {required int publishCnt}) async {
    return _getImagePresignedInfos(publishCnt, Endpoints.uploadThumbPresign);
  }

  Future<_Presigned> _getProfilePresignedInfo() async {
    return _getImagePresignedInfo(Endpoints.uploadProfilePresign);
  }

  Future<_Presigned> _getVideoPresignedInfo() async {
    http.Response response = await http.post(
      Uri.parse(Endpoints.apiUrl + Endpoints.uploadVideoPresign),
      headers: {"access-token": getIt<MemberInfo>().accessToken!},
    );

    final responseBody = response.body;
    final responseJson = json.decode(responseBody);
    final String mp4Key = responseJson["result"]["key"];
    final String url = responseJson["result"]["url"];

    return _Presigned(mp4Key, url);
  }

  Future<List<_Presigned>> _getImagePresignedInfos(
      int publishCnt, String urlPath) async {
    http.Response response =
        await http.post(Uri.parse(Endpoints.apiUrl + urlPath),
            headers: {
              "content-type": "application/json",
              "access-token": getIt<MemberInfo>().accessToken!
            },
            body: json.encode({"publish_count": publishCnt}));

    final List presigneds = json.decode(response.body)["result"];

    return presigneds
        .map((presigned) => _Presigned(presigned["key"], presigned["url"]))
        .toList();
  }

  Future<_Presigned> _getImagePresignedInfo(String urlPath) async {
    http.Response response = await http.post(
      Uri.parse(Endpoints.apiUrl + urlPath),
      headers: {
        "content-type": "application/json",
        "access-token": getIt<MemberInfo>().accessToken!
      },
    );

    final presigned = json.decode(response.body)["result"];

    return _Presigned(presigned["key"], presigned["url"]);
  }

  Future<void> _uploadVideoToSignedURL(
      {required File file,
      required String presignedUrl,
      void Function(int sentBytes, int totalBytes)? onSendProgress}) async {
    final Dio dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));
    await dio.putUri<void>(
      Uri.parse(presignedUrl),
      data: file.openRead(),
      options: Options(headers: <String, dynamic>{
        HttpHeaders.contentTypeHeader: ContentType('video', 'mp4').toString(),
        HttpHeaders.contentLengthHeader: await file.length(),
      }),
      onSendProgress: onSendProgress,
    );
  }

  Future<void> _uploadImageToSignedURL(
      {required File file,
      required String presignedUrl,
      void Function(int sentBytes, int totalBytes)? onSendProgress}) async {
    final Dio dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));
    await dio.putUri<void>(
      Uri.parse(presignedUrl),
      data: file.openRead(),
      options: Options(headers: <String, dynamic>{
        HttpHeaders.contentTypeHeader: ContentType('image', 'jpg').toString(),
        HttpHeaders.contentLengthHeader: await file.length(),
      }),
      onSendProgress: onSendProgress,
    );
  }

  Future<File?> _extractProfile(File file) async {
    final desPath =
        "${dirname(file.path)}/${basenameWithoutExtension(file.path)}-thumbnail.jpg";

    return await FlutterImageCompress.compressAndGetFile(
      file.path,
      desPath,
      quality: 50,
      minWidth: 100,
      minHeight: 100,
    );
  }

  Future<File?> _extractThumbnail(File file) async {
    final desPath =
        "${dirname(file.path)}/${basenameWithoutExtension(file.path)}-thumbnail.jpg";

    return await FlutterImageCompress.compressAndGetFile(
      file.path,
      desPath,
      quality: 50,
      minWidth: 200,
    );
  }

  Future<File?> _resizeVideoFile(File videoFile) async {
    final videoData =
        (await getIt<FlutterVideoInfo>().getVideoInfo(videoFile.path))!;

    final videoAspectRatio = videoData.width! < videoData.height!
        ? videoData.width! / videoData.height!
        : videoData.height! / videoData.width!;

    final isRegularSize = videoAspectRatio == _reelsAspectRatio;

    File desFile = File(join(dirname(videoFile.path),
        "${basenameWithoutExtension(videoFile.path)}-resized-${DateTime.now().millisecondsSinceEpoch}.mp4"));

    return FFmpegKit.execute(await _getCommandResizeVideo(
            videoFile.path, desFile.path, isRegularSize))
        .then((session) {
      session.getLogs().then((logs) {
        for (final log in logs) {
          safePrint("log: ${log.getMessage()}");
        }
      });
      return session.getReturnCode();
    }).then((returnCode) {
      safePrint(
          "returnCode: $returnCode, isSuccess: ${ReturnCode.isSuccess(returnCode)}");
      return ReturnCode.isSuccess(returnCode);
    }).then((isSuccess) => isSuccess ? desFile : null);
  }

  Future<String> _getCommandResizeVideo(
      String srcPath, String desPath, bool isRegularSize) async {
    final scaleRatioClause = isRegularSize ? "720:1280" : "-1:720";

    return "-i $srcPath -c:a copy -c:v libx264 -vf scale=$scaleRatioClause -crf 28 -preset veryfast $desPath";
  }
}

class _Presigned {
  final String key;
  final String url;

  _Presigned(this.key, this.url);

  @override
  String toString() {
    return "_Presigned(key=$key, url=$url)";
  }
}
