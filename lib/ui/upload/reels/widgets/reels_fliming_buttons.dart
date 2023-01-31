import 'package:dingmo/utils/typedef.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants/colors.dart';
import '../../../widgets/countdown_progress_indicator.dart';
import '../../../widgets/texts.dart';

class PickFromGalleryButton extends StatelessWidget {
  final void Function(PlatformFile? video) onVideoSelected;

  const PickFromGalleryButton({Key? key, required this.onVideoSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pickVideo,
      child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: AppColors.greyWhite,
              border: Border.all(color: AppColors.greyWhite, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("assets/dingmo.png"),
          )),
    );
  }

  void pickVideo() {
    FilePicker.platform
        .pickFiles(type: FileType.video, allowMultiple: false)
        .then((result) => onVideoSelected(result?.files[0]));
  }
}

class CameraModeChangeButton extends StatelessWidget {
  final VoidFunc onPressed;
  const CameraModeChangeButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              border: Border.all(color: Colors.transparent, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:
                SvgPicture.asset("assets/home/make_contents/arrows_icon.svg"),
          ),
        ));
  }
}

class StartVideoRecordingButton extends StatelessWidget {
  final VoidFunc onPressed;
  const StartVideoRecordingButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(99),
                color: Colors.white.withOpacity(0.5)),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class StopVideoRecordingButton extends StatefulWidget {
  final VoidFunc onPressed;
  final VoidFunc onAutoComplete;
  final void Function(int progress)? onProgress;
  final int minRecordSecond;
  const StopVideoRecordingButton({
    Key? key,
    required this.onPressed,
    required this.onAutoComplete,
    required this.minRecordSecond,
    this.onProgress,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StopVideoRecordingButtonState();
}

class StopVideoRecordingButtonState extends State<StopVideoRecordingButton> {
  int currentProgress = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 106,
            height: 106,
            child: CountDownProgressIndicator(
                duration: 15,
                strokeWidth: 5,
                onComplete: currentProgress > widget.minRecordSecond
                    ? widget.onAutoComplete
                    : () {},
                onProgress: (progress) {
                  if (currentProgress != progress) {
                    setState(() => currentProgress = progress);
                    if (widget.onProgress != null) {
                      widget.onProgress!(progress);
                    }
                  }
                },
                backgroundColor: Colors.white,
                valueColor: AppColors.mediumPink),
          ),
          GestureDetector(
            onTap: currentProgress > widget.minRecordSecond
                ? widget.onPressed
                : () {},
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99), color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}

class SoundSelectionButton extends StatelessWidget {
  final void Function() onPressed;
  const SoundSelectionButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          const SizedBox(height: 10),
          SvgPicture.asset("assets/home/make_contents/music_icon.svg"),
          const SizedBox(height: 4),
          Texts.defaultText(
              text: "사운드",
              fontSize: 13,
              color: Colors.white,
              fontWeight: FontWeight.normal)
        ],
      ),
    );
  }
}

class BottomButtonsMargin extends StatelessWidget {
  const BottomButtonsMargin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: ((MediaQuery.of(context).size.width - (40 + 80 + 40)) / 4));
  }
}
