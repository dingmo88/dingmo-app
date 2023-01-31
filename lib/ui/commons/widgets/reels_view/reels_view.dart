import 'dart:async';

import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/ui/commons/widgets/reels_action/reels_action_default.dart';
import 'package:dingmo/ui/widgets/reels_fit.dart';
import 'package:dingmo/ui/upload/reels/items/reels_item.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:video_player/video_player.dart';

import '../reels_action/reels_action.dart';
import '../reels_video.dart';

class ReelsView extends StatefulWidget {
  final Future<GetShortsResult?> reelsItemFuture;
  final bool playOnReady;
  final bool isInSingle;
  final VoidFunc onReelsUpdated;
  const ReelsView({
    Key? key,
    required this.reelsItemFuture,
    required this.onReelsUpdated,
    this.playOnReady = false,
    this.isInSingle = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => ReelsViewState();
}

class ReelsViewState<T extends ReelsView> extends State<T>
    with WidgetsBindingObserver {
  VideoPlayerController? _videoController;
  late final ReelsItem? _reelsItem;

  late final Future<VideoPlayerController?> _readyFuture;

  bool _pausedByOutside = false;

  Future<VideoPlayerController?> _loadController() async {
    final reelsResult = await widget.reelsItemFuture;

    _reelsItem = reelsResult != null ? ReelsItem(data: reelsResult) : null;

    if (_reelsItem != null) {
      _videoController = VideoPlayerController.network(
          path.join(Endpoints.vodUrl, _reelsItem!.data.m3u8Key));

      await _videoController?.initialize();
      _videoController?.setLooping(true);

      return _videoController;
    } else {
      return null;
    }
  }

  Future<void> play() async {
    if (_pausedByOutside) {
      return;
    }

    await _readyFuture;
    if (_videoController?.value.isPlaying == false) {
      FlutterNativeSplash.remove();
      await _videoController!.play();
    }
  }

  Future<void> pause() async {
    if (_pausedByOutside) {
      return;
    }

    await _readyFuture;
    if (_videoController?.value.isPlaying == true) {
      await _videoController!.pause();
    }
  }

  @override
  void initState() {
    super.initState();

    _readyFuture = _loadController();
    _readyFuture.then((controller) {
      if (controller == null) {
        Fluttertoast.showToast(msg: "잘못된 접근입니다");
        if (widget.isInSingle) {
          Navigator.pop(context);
        }
      }
    });

    if (widget.playOnReady) {
      play();
    }

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      await pause();
    } else if (state == AppLifecycleState.resumed) {
      await play();
    }
  }

  bool _visiblePlay = false;
  bool _playFadeIn = false;

  bool _visiblePause = false;
  bool _pauseFadeIn = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<VideoPlayerController?>(
      future: _readyFuture,
      builder: (BuildContext context,
          AsyncSnapshot<VideoPlayerController?> snapshot) {
        if (snapshot.hasData) {
          final videoControllerSnapshot = snapshot.data!;
          _videoController = videoControllerSnapshot;

          return Stack(
            children: [
              ReelsFittedBox(
                  child: ReelsVideo(controller: videoControllerSnapshot)),
              ReelsActionWidget(
                reelsInfo: _reelsItem!,
                isInSingle: widget.isInSingle,
                onReelsUpdated: widget.onReelsUpdated,
                onRoutePopped: () async {
                  _pausedByOutside = false;
                  await play();
                },
                onRoutePushed: () async {
                  await pause();
                  _pausedByOutside = true;
                },
                onTabBackground: () {
                  if (videoControllerSnapshot.value.isPlaying) {
                    showAnimatePause();
                    pause();
                  } else {
                    showAnimatePlay();
                    play();
                  }
                },
                onChangeSoundVolume: onChangeSoundVolume,
              ),
              Visibility(
                  visible: _visiblePause,
                  child: AnimatedOpacity(
                    onEnd: () {
                      setState(() {
                        _visiblePause = !_visiblePause;
                      });
                    },
                    opacity: _pauseFadeIn ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 400),
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: SvgPicture.asset("assets/home/stop_icon.svg"),
                        )),
                  )),
              Visibility(
                  visible: _visiblePlay,
                  child: AnimatedOpacity(
                    onEnd: () {
                      setState(() {
                        _visiblePlay = !_visiblePlay;
                      });
                    },
                    opacity: _playFadeIn ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 400),
                    child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 60,
                          height: 60,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: SvgPicture.asset("assets/home/play_icon.svg"),
                        )),
                  )),
            ],
          );
        } else {
          return Container(
            color: Colors.white,
            child: const ReelsActionDefaultWidget(),
          );
        }
      },
    );
  }

  void showAnimatePlay() {
    setState(() {
      _visiblePause = false;
      _visiblePlay = !_visiblePlay;
    });
    setState(() {
      _playFadeIn = !_playFadeIn;
    });
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        _playFadeIn = !_playFadeIn;
      });
    });
  }

  void showAnimatePause() {
    setState(() {
      _visiblePlay = false;
      _visiblePause = !_visiblePause;
    });
    setState(() {
      _pauseFadeIn = !_pauseFadeIn;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _pauseFadeIn = !_pauseFadeIn;
      });
    });
  }

  void onChangeSoundVolume(bool soundOn) {
    if (soundOn) {
      _videoController!.setVolume(1);
    } else {
      _videoController!.setVolume(0);
    }
  }

  @override
  void dispose() async {
    super.dispose();

    await _readyFuture;
    await _videoController?.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }
}
