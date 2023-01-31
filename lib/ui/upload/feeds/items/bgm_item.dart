import 'package:audioplayers/audioplayers.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ReelsBgmItemWidget extends StatefulWidget {
  final String name;
  final String asset;
  final bool isSelectedToPlay;
  final void Function() onPressed;
  const ReelsBgmItemWidget(
      {Key? key,
      required this.name,
      required this.asset,
      required this.onPressed,
      this.isSelectedToPlay = false})
      : super(key: key);

  @override
  State<ReelsBgmItemWidget> createState() => ReelsBgmItemWidgetState();
}

class ReelsBgmItemWidgetState extends State<ReelsBgmItemWidget> {
  final AudioPlayer _player = AudioPlayer();

  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.isSelectedToPlay) {
        play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: AppColors.white, width: 1))),
          child: Row(children: [
            radioCheckButton(),
            const SizedBox(width: 10),
            Text(widget.name)
          ])),
    );
  }

  Widget radioCheckButton() {
    return widget.isSelectedToPlay
        ? Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mediumPink, width: 1.2),
                    borderRadius: BorderRadius.circular(99)),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                    color: AppColors.mediumPink,
                    borderRadius: BorderRadius.circular(99)),
              )
            ],
          )
        : Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyishBrown, width: 1.2),
                borderRadius: BorderRadius.circular(99)),
          );
  }

  Future<void> play() async {
    if (_isPlaying) {
      return;
    }
    await _player.play(AssetSource(widget.asset));
    _isPlaying = true;
  }

  Future<void> stop() async {
    if (!_isPlaying) {
      return;
    }

    await _player.stop();
    _isPlaying = false;
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
