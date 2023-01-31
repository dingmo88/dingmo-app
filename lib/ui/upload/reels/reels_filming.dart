import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/widgets/reels_fit.dart';
import 'package:dingmo/routes/arguments/arg_reels_preview.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/media_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/reels_fliming_buttons.dart';

class ReelsFilmingPage extends StatefulWidget {
  final bool pushReplacementHome;
  final CameraDescription frontCamera;
  final CameraDescription backCamera;
  const ReelsFilmingPage(
      {Key? key,
      required this.backCamera,
      required this.frontCamera,
      this.pushReplacementHome = false})
      : super(key: key);

  @override
  State<ReelsFilmingPage> createState() => _ReelsFilmingPageState();
}

class _ReelsFilmingPageState extends State<ReelsFilmingPage>
    with WidgetsBindingObserver {
  CameraController? cameraController;
  late Future<void> initCameraControllerFuture;
  bool cameraChanging = false;
  bool _isInverting = false;
  @override
  void initState() {
    super.initState();
    initCameraControllerFuture = setBackCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() async {
    await releaseCamera();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.inactive) {
      await releaseCamera();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  void initCamera() {
    if (!isInitCamera()) {
      setState(() {
        initCameraControllerFuture = setBackCamera();
      });
    }
  }

  Future<void> releaseCamera() async {
    if (isInitCamera()) {
      await cameraController!.dispose();
      cameraController = null;
    }
  }

  bool isInitCamera() {
    return cameraController?.value.isInitialized == true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (widget.pushReplacementHome) {
            Navigator.pushReplacementNamed(context, Routes.start);
          }
          return !_isInverting;
        },
        child: Stack(
          children: [
            FutureBuilder(
                future: initCameraControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    setCameraChanging(false);
                    return ReelsFittedBox(
                      child: CameraPreview(cameraController!),
                    );
                  } else {
                    return Container();
                  }
                }),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(children: [
                Container(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BottomButtonsMargin(),
                    IgnorePointer(
                      ignoring: isVideoRecording(),
                      child: PickFromGalleryButton(
                        onVideoSelected: (PlatformFile? video) async {
                          if (video?.path != null) {
                            await tryGoVideoPreviewPage(ReelsPreviewArgs(
                                videoFile: File(video!.path!)));
                          }
                        },
                      ),
                    ),
                    const BottomButtonsMargin(),
                    recordButton(),
                    const BottomButtonsMargin(),
                    IgnorePointer(
                      ignoring: isVideoRecording(),
                      child: CameraModeChangeButton(onPressed: trySwitchCamera),
                    ),
                    const BottomButtonsMargin(),
                  ],
                ),
                const SizedBox(height: 60)
              ]),
            ),
            Visibility(
                visible: _isInverting,
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.mediumPink,
                  ),
                ))
          ],
        ));
  }

  void trySwitchCamera() {
    if (isInitCamera() && !isCameraChanging()) {
      setCameraChanging(true);
      isFrontCamera()
          ? initCameraControllerFuture = setBackCamera()
          : initCameraControllerFuture = setFrontCamera();
      setState(() {});
    }
  }

  bool isFrontCamera() {
    return cameraController?.description.lensDirection ==
        CameraLensDirection.front;
  }

  Future<void> setCamera(CameraDescription camera) async {
    await releaseCamera();
    cameraController = CameraController(camera, ResolutionPreset.max);
    await cameraController!.initialize();
  }

  Future<void> setFrontCamera() async {
    return setCamera(widget.frontCamera);
  }

  Future<void> setBackCamera() async {
    return setCamera(widget.backCamera);
  }

  Widget recordButton() {
    return isVideoRecording()
        ? StopVideoRecordingButton(
            onPressed: stopVideoRecordingButtonPressed,
            onAutoComplete: stopVideoRecordingButtonPressed,
            minRecordSecond: 3)
        : StartVideoRecordingButton(
            onPressed: startVideoRecordingButtonPressed);
  }

  void startVideoRecordingButtonPressed() async {
    if (!isCameraChanging()) {
      await startVideoRecording();
      setState(() {});
    }
  }

  void stopVideoRecordingButtonPressed() async {
    if (!isCameraChanging()) {
      await tryGoVideoPreviewPage(ReelsPreviewArgs(
          videoFile: File((await stopVideoRecording()).path),
          inverted: isFrontCamera(),
          isFilmed: true));
      setState(() {});
    }
  }

  Future<void> startVideoRecording() async {
    await cameraController!.startVideoRecording();
  }

  Future<XFile> stopVideoRecording() {
    return cameraController!.stopVideoRecording();
  }

  Future<void> tryGoVideoPreviewPage(ReelsPreviewArgs args) async {
    final videoUtil = getIt<MediaUtil>();
    final vaildResult = await videoUtil.validateVideo(args.videoFile.path);

    if (vaildResult == VideoVaildState.ok) {
      if (args.inverted) {
        setState(() {
          _isInverting = true;
        });
        Fluttertoast.showToast(
            msg: "좌우 반전 처리 중입니다 최대 몇 분 소요됩니다", toastLength: Toast.LENGTH_LONG);
        final invertedVideo = await videoUtil.getInverted(args.videoFile.path);

        if (invertedVideo == null) {
          Fluttertoast.showToast(msg: "처리 중 문제가 발생하였습니다");
          return;
        }

        goVideoPreviewPage(ReelsPreviewArgs(
            isFilmed: args.isFilmed,
            inverted: args.inverted,
            videoFile: invertedVideo));
      } else {
        goVideoPreviewPage(args);
      }
    } else {
      if (vaildResult == VideoVaildState.invalidVideo) {
        Fluttertoast.showToast(msg: "영상 형식이 올바르지 않습니다");
      } else if (vaildResult == VideoVaildState.invalidRatio) {
        Fluttertoast.showToast(msg: "세로 모드 영상만 가능합니다");
      } else if (vaildResult == VideoVaildState.overDuration) {
        Fluttertoast.showToast(msg: "영상 길이는 15초를 초과할 수 없습니다");
      }
    }
  }

  void goVideoPreviewPage(ReelsPreviewArgs args) {
    Navigator.pushReplacementNamed(context, Routes.reelsPreview,
            arguments: args)
        .then((_) => setState(() {
              _isInverting = false;
            }));
  }

  bool isCameraChanging() {
    return cameraChanging;
  }

  void setCameraChanging(bool value) {
    cameraChanging = value;
  }

  bool isVideoRecording() {
    return cameraController?.value.isRecordingVideo == true;
  }
}
