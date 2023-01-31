import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class TaggingWidget extends StatefulWidget {
  final void Function(String text) onSubmitted;
  const TaggingWidget({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  State<TaggingWidget> createState() => _TaggingWidgetState();
}

class _TaggingWidgetState extends State<TaggingWidget> {
  FocusNode etcTagFocus = FocusNode();
  late final TextEditingController etcTagController = TextEditingController();

  @override
  void initState() {
    super.initState();

    etcTagController.addListener(() {
      if (etcTagController.text.isNotEmpty) {
        if (etcTagController.selection.base.offset <
            etcTagController.text.length) {
          etcTagController.selection = TextSelection.fromPosition(
              TextPosition(offset: etcTagController.text.length));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        maxLength: 20,
        focusNode: etcTagFocus,
        controller: etcTagController,
        textInputAction: TextInputAction.newline,
        onChanged: onTagTextListener,
        decoration: InputDecoration.collapsed(
            focusColor: Colors.red,
            hintText: "#태그추가하기",
            hintStyle: TextStyle(fontSize: 14, color: AppColors.veryLightPink)),
        onFieldSubmitted: addEtcTag,
        style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
      ),
    );
  }

  void onTagTextListener(String text) {
    String trimmedText = text.trim();

    if (trimmedText.isEmpty) {
      etcTagController.clear();
    } else if (trimmedText.length < text.length) {
      widget.onSubmitted(text.replaceAll(" ", "").replaceAll("#", ""));
      etcTagController.clear();
    }
  }

  void addEtcTag(String tag) {
    if (tag.isNotEmpty) {
      widget.onSubmitted(tag.replaceAll(" ", "").replaceAll("#", ""));
      etcTagController.clear();
    }
  }
}
