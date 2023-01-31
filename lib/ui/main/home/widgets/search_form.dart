import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/input_forms.dart';

class SearchFormWidget extends StatefulWidget {
  final void Function(String text) onTextChanged;
  final void Function(String text) onSubmitted;
  final void Function(bool focus) onFocusChanged;
  const SearchFormWidget(
      {Key? key,
      required this.onTextChanged,
      required this.onSubmitted,
      required this.onFocusChanged})
      : super(key: key);

  @override
  State<SearchFormWidget> createState() => _SearchFormWidgetState();
}

class _SearchFormWidgetState extends State<SearchFormWidget> {
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchFormController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      widget.onFocusChanged(searchFocusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (searchFocusNode.hasFocus) {
          searchFocusNode.unfocus();
          return false;
        }
        return true;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.maybePop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.all(5),
                  child: const Icon(Icons.arrow_back),
                )),
            const SizedBox(width: 10),
            Flexible(
              child: InputForms.textInputForm(
                  searchFocusNode, searchFormController, widget.onTextChanged,
                  hint: "궁금한 웨딩정보를 검색해보세요",
                  suffixIcon: GestureDetector(
                      onTap: searchFormController.text.isNotEmpty
                          ? () => setState(() => searchFormController.clear())
                          : null,
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(12),
                        child: searchFormController.text.isNotEmpty
                            ? SvgPicture.asset(
                                "assets/home/tag_delete_icon.svg",
                              )
                            : SvgPicture.asset(
                                "assets/home/search_icon.svg",
                              ),
                      )),
                  onSubmitted: widget.onSubmitted),
            )
          ],
        ),
      ),
    );
  }
}
