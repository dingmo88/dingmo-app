import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/commons/widgets/reels_video.dart';
import 'package:dingmo/ui/widgets/buttons.dart';
import 'package:dingmo/ui/widgets/reels_fit.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/routes/arguments/arg_reels_bgm_selection.dart';
import 'package:dingmo/routes/arguments/arg_reels_upload.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

import '../../../routes/arguments/args_reels_filming.dart';
import 'widgets/reels_fliming_buttons.dart';

class ReelsPreviewPage extends StatefulWidget {
  final File videoFile;
  final bool isFilmed;
  const ReelsPreviewPage(
      {Key? key, required this.videoFile, required this.isFilmed})
      : super(key: key);

  @override
  State<ReelsPreviewPage> createState() => _ReelsPreviewPageState();
}

class _ReelsPreviewPageState extends State<ReelsPreviewPage> {
  late final VideoPlayerController videoController;
  final AudioPlayer audioPlayer = AudioPlayer();
  String? selectedAudioAsset;
  bool pauseByUser = false;

  Future<void> loading() async {
    videoController = VideoPlayerController.file(widget.videoFile);
    await videoController.initialize();
    await videoController.setLooping(true);
    await videoController.play();
  }

  @override
  void dispose() async {
    super.dispose();
    await audioPlayer.dispose();
    await videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          availableCameras().then((cameras) {
            Navigator.pushReplacementNamed(context, Routes.reelsFilming,
                    arguments: ReelsFilmingArgs(
                        pushReplacementHome: true,
                        backCamera: cameras.firstWhere(isBackCamera),
                        frontCamera: cameras.lastWhere(isFrontCamera)))
                .then((_) {});
          });
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: FutureBuilder(
              future: loading(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return GestureDetector(
                    onTap: () async {
                      if (isPlaying()) {
                        await pause();
                        pauseByUser = true;
                      } else {
                        play();
                        pauseByUser = false;
                      }
                    },
                    child: ReelsFittedBox(
                        height: MediaQuery.of(context).size.height - 60,
                        child: ReelsVideo(controller: videoController)),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: SoundSelectionButton(
                      onPressed: () async {
                        Fluttertoast.showToast(msg: "coming soon!");
                        // if (isSelectedAudio()) {
                        //   showSoundActionBottomSheet(goSoundSelectionPage);
                        // } else {
                        //   await goSoundSelectionPage();
                        // }
                      },
                    ),
                  ),
                  Buttons.defaultButton(
                    text: "다음",
                    onPressed: () async {
                      showAlertCopyrightBottomSheet(goReelsUploadPage);
                      // if (isOriginalVideoFromGallery()) {
                      //   showAlertCopyrightBottomSheet(goReelsUploadPage);
                      // } else {
                      //   await goReelsUploadPage();
                      // }
                    },
                  )
                ]),
          ),
        ));
  }

  bool isFrontCamera(CameraDescription camera) {
    return camera.lensDirection == CameraLensDirection.front;
  }

  bool isBackCamera(CameraDescription camera) {
    return camera.lensDirection == CameraLensDirection.back;
  }

  Future<void> goSoundSelectionPage() {
    return pause().then((value) {
      Navigator.pushNamed(context, Routes.reelsBgmSelection,
              arguments: ReelsBgmSelectionArgs(selectedIndex: 0))
          .then((selectedSound) {
        if (selectedSound != null) {
          selectedAudioAsset = selectedSound as String?;
        }
        if (!pauseByUser) {
          return play();
        }
      });
    });
  }

  Future<void> goReelsUploadPage() async {
    return pause().then((value) {
      Navigator.pushNamed(context, Routes.reelsUpload,
          arguments: ReelsUploadArgs(
            videoFile: widget.videoFile,
            videoDuration: videoController.value.duration,
          )).then((_) {
        if (!pauseByUser) {
          return play();
        }
      });
    });
  }

  Future<void> play() async {
    if (selectedAudioAsset != null) {
      await videoController.setVolume(0);
      await videoController.play();
      await audioPlayer.play(AssetSource(selectedAudioAsset!));
    } else {
      await videoController.setVolume(1);
      await videoController.play();
    }
  }

  Future<void> pause() async {
    if (selectedAudioAsset != null) {
      await videoController.pause();
      await audioPlayer.pause();
    } else {
      await videoController.pause();
    }
  }

  void showAlertCopyrightBottomSheet(Future<void> Function() onPressedOk) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: 160,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Texts.defaultText(
                        text: "사운드 주의사항",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        await onPressedOk();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 10, top: 10, bottom: 10),
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        child: Text(
                          "확인",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.mediumPink,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Texts.defaultText(
                    text: "딩모 외 외부에서 가져온 영상의 경우, 음악 저작권\n"
                        "문제 발생으로 사운드가 삭제 될 수 있음을 알려드립니다.",
                    fontSize: 14)
              ],
            ),
          ),
        );
      },
    );
  }

  void showSoundActionBottomSheet(VoidFunc onPressedOk) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Texts.defaultText(
                        text: "사운드", fontSize: 16, fontWeight: FontWeight.bold),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onPressedOk();
                      },
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onPressedOk();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Texts.defaultText(
                          text: "사운드 변경",
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    )),
                GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      await pause();
                      selectedAudioAsset = null;
                      await play();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Texts.defaultText(
                          text: "사운드 삭제",
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  bool isPlaying() {
    return videoController.value.isPlaying;
  }

  bool isSelectedAudio() {
    return selectedAudioAsset != null;
  }

  bool isOriginalVideoFromGallery() {
    return !widget.isFilmed && !isSelectedAudio();
  }
}
