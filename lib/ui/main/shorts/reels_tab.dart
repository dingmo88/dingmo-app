import 'package:dingmo/ui/commons/reels.dart';
import 'package:flutter/material.dart';

class ReelsTab extends StatefulWidget {
  final bool Function() onSelected;
  const ReelsTab({GlobalKey<ReelsTabState>? key, required this.onSelected})
      : super(key: key);

  @override
  State<ReelsTab> createState() => ReelsTabState();
}

class ReelsTabState extends State<ReelsTab> {
  @override
  Widget build(BuildContext context) {
    return ReelsListPage(
      isPlayable: widget.onSelected,
    );
  }
}
