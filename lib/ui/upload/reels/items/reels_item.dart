import 'package:dingmo/api/api_shorts.dart';

class ReelsItem {
  final GetShortsResult data;
  bool soundOn;

  ReelsItem({
    required this.data,
    this.soundOn = true,
  });
}
