import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelsVideo extends StatefulWidget {
  final VideoPlayerController controller;

  const ReelsVideo({Key? key, required this.controller}) : super(key: key);

  @override
  State<ReelsVideo> createState() => _ReelsVideoState();
}

class _ReelsVideoState extends State<ReelsVideo> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.controller.value.aspectRatio,
      child: VideoPlayer(widget.controller),
    );
  }
}
