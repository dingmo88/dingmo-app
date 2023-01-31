import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';

import 'input_forms.dart';

class TextForm extends BaseForm {
  final TextEditingController controller;
  final SetStringFunc onChanged;
  final Widget? suffixIcon;
  final String? hint;
  final bool? isEnabled;
  final EdgeInsets? suffixPadding;

  TextForm(
      {Key? key,
      required FocusNode focusNode,
      required String name,
      required this.controller,
      required this.onChanged,
      this.suffixIcon,
      this.suffixPadding,
      this.hint,
      this.isEnabled})
      : super(
            key: key,
            focusNode: focusNode,
            name: name,
            form: InputForms.textInputForm(focusNode, controller, onChanged,
                suffixIcon: suffixIcon,
                hint: hint,
                isEnabled: isEnabled,
                suffixPadding: suffixPadding));

  @override
  State<TextForm> createState() => _TextFormState();
}

class NumForm extends BaseForm {
  final TextEditingController controller;
  final SetStringFunc onChanged;
  final Widget? suffixIcon;
  final String? hint;
  final bool? isEnabled;

  NumForm(
      {Key? key,
      required FocusNode focusNode,
      required String name,
      required this.controller,
      required this.onChanged,
      this.suffixIcon,
      this.hint,
      this.isEnabled})
      : super(
            key: key,
            focusNode: focusNode,
            name: name,
            form: InputForms.numInputForm(focusNode, controller, onChanged,
                suffixIcon: suffixIcon, hint: hint));

  @override
  State<NumForm> createState() => _NumFormState();
}

class PassForm extends BaseForm {
  final TextEditingController controller;
  final SetStringFunc onChanged;
  final bool obsecureText;
  final Widget? suffixIcon;
  final String? hint;

  PassForm(
      {Key? key,
      required FocusNode focusNode,
      required String name,
      required this.controller,
      required this.onChanged,
      required this.obsecureText,
      this.suffixIcon,
      this.hint})
      : super(
            key: key,
            focusNode: focusNode,
            name: name,
            form: InputForms.passInutForm(
                focusNode, controller, onChanged, obsecureText,
                suffixIcon: suffixIcon, hint: hint));

  @override
  State<PassForm> createState() => _PassFormState();
}

class MultiLineLimitTextForm extends BaseForm {
  final TextEditingController controller;
  final SetStringFunc onChanged;
  final int maxLines;
  final int maxLength;
  final Widget? suffixIcon;
  final String? hint;

  MultiLineLimitTextForm(
      {Key? key,
      required FocusNode focusNode,
      required String name,
      required this.controller,
      required this.onChanged,
      required this.maxLines,
      required this.maxLength,
      this.suffixIcon,
      this.hint})
      : super(
            key: key,
            focusNode: focusNode,
            name: name,
            form: InputForms.multiLineLimitTextForm(
                focusNode, controller, onChanged, maxLines, maxLength,
                suffixIcon: suffixIcon, hint: hint));

  @override
  State<MultiLineLimitTextForm> createState() => _MultiLineLimitTextFormState();
}

class BaseForm extends StatefulWidget {
  final FocusNode focusNode;
  final String name;
  final Widget form;
  const BaseForm(
      {Key? key,
      required this.focusNode,
      required this.name,
      required this.form})
      : super(key: key);

  @override
  State<BaseForm> createState() => FormState();
}

class FormState<T extends BaseForm> extends State<T> {
  Color formNameColor = AppColors.greyishBrown;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    widget.focusNode.removeListener(_onFocusChange);
    widget.focusNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      formNameColor = widget.focusNode.hasFocus
          ? AppColors.mediumPink
          : AppColors.greyishBrown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.name,
        style: TextStyle(
            color: formNameColor, fontSize: 13, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 10),
      widget.form,
    ]);
  }
}

class _TextFormState extends FormState<TextForm> {}

class _NumFormState extends FormState<NumForm> {}

class _PassFormState extends FormState<PassForm> {}

class _MultiLineLimitTextFormState extends FormState<MultiLineLimitTextForm> {}
