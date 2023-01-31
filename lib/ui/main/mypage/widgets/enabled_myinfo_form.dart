import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/form.dart';
import 'package:flutter/material.dart';

class EnabledMyInfoFormWidget extends StatefulWidget {
  final String name;
  final String content;
  final void Function(String newText)? onSubmit;
  const EnabledMyInfoFormWidget(
      {Key? key, required this.name, required this.content, this.onSubmit})
      : super(key: key);

  @override
  State<EnabledMyInfoFormWidget> createState() =>
      _EnabledMyInfoFormWidgetState();
}

class _EnabledMyInfoFormWidgetState extends State<EnabledMyInfoFormWidget> {
  final FocusNode formFocusNode = FocusNode();
  final TextEditingController formController = TextEditingController();

  @override
  void initState() {
    super.initState();

    formController.text = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return TextForm(
      name: widget.name,
      focusNode: formFocusNode,
      controller: formController,
      suffixPadding: const EdgeInsets.only(),
      onChanged: (text) => setState(() {}),
      suffixIcon: TextButton(
          onPressed: () => widget.onSubmit != null
              ? widget.onSubmit!(formController.text)
              : {},
          child: Text(
            "변경",
            style: TextStyle(fontSize: 13, color: AppColors.mediumPink),
          )),
    );
  }
}
