import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  final double size;
  final double spacing;
  final Color selectedColor;
  final Color unselectedColor;
  final int itemCount;
  final int selectedIndex;
  const PageIndicator({
    Key? key,
    required this.size,
    required this.spacing,
    required this.selectedColor,
    required this.unselectedColor,
    required this.itemCount,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  final List<Widget> indicators = [];
  final List<Widget> indicatorSpacing = [];
  final Map<int, bool> selected = {};

  @override
  Widget build(BuildContext context) {
    setSelection();
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: selected.map(indicator).values.toList());
  }

  void setSelection() {
    for (int idx = 0; idx < widget.itemCount; idx++) {
      selected[idx] = idx == widget.selectedIndex;
    }
  }

  MapEntry<int, Widget> indicator(int index, bool isSelected) {
    return MapEntry(
        index,
        Container(
          margin: EdgeInsets.symmetric(horizontal: widget.spacing),
          decoration: BoxDecoration(
              color: isSelected ? widget.selectedColor : widget.unselectedColor,
              borderRadius: BorderRadius.circular(99)),
          width: widget.size,
          height: widget.size,
        ));
  }
}
