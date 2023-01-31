import 'package:dingmo/ui/upload/feeds/items/bgm_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../widgets/buttons.dart';

class ReelsBgmSelectionPage extends StatefulWidget {
  final int selectedIndex;
  const ReelsBgmSelectionPage({Key? key, required this.selectedIndex})
      : super(key: key);

  @override
  State<ReelsBgmSelectionPage> createState() => _ReelsBgmSelectionPageState();
}

class _ReelsBgmSelectionPageState extends State<ReelsBgmSelectionPage> {
  final Map<int, GlobalKey<ReelsBgmItemWidgetState>> bgmStateKeys = {};
  final List<String> bgmNames = [
    "Fragment",
    "Phantom Grip",
    "Recovery",
  ];
  final List<String> bgmAssets = [
    "samples/bgms/fragment.mp3",
    "samples/bgms/phantom_grip.mp3",
    "samples/bgms/recovery.mp3",
  ];

  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.closableAppBar(context,
          title: "사운드",
          action: Container(
              padding: const EdgeInsets.only(right: 15),
              child: Buttons.textButton(
                  text: "완료",
                  onTap: () =>
                      Navigator.pop<String?>(context, bgmAssets[selectedIndex]),
                  color: AppColors.mediumPink,
                  fontSize: 13,
                  fontWeight: FontWeight.w500))),
      body: ListView.builder(
        itemCount: bgmAssets.length,
        itemBuilder: (BuildContext context, int index) {
          final key = GlobalKey<ReelsBgmItemWidgetState>();
          bgmStateKeys[index] = key;

          return ReelsBgmItemWidget(
            key: key,
            name: bgmNames[index],
            asset: bgmAssets[index],
            onPressed: () {
              setState(() => selectedIndex = index);
              playSelectedSound();
            },
            isSelectedToPlay: selectedIndex == index,
          );
        },
      ),
    );
  }

  void playSelectedSound() {
    bgmStateKeys.forEach((idx, bgmStateKey) async {
      await bgmStateKey.currentState?.stop();
    });
  }
}
