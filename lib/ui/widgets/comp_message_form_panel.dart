import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'buttons.dart';
import 'message_cancel_dialog.dart';

class CompMessageFormPanel extends StatefulWidget {
  final Widget contentWidget;
  final void Function(String message) onCompleteWriteMessage;
  const CompMessageFormPanel(
      {Key? key,
      required this.contentWidget,
      required this.onCompleteWriteMessage})
      : super(key: key);

  @override
  State<CompMessageFormPanel> createState() => _CompMessageFormPanelState();
}

class _CompMessageFormPanelState extends State<CompMessageFormPanel> {
  final FocusNode writeMessageFocusNode = FocusNode();
  final TextEditingController writeMessageController = TextEditingController();

  final ExpandableController panelController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (writeMessageController.text.isNotEmpty) {
          showMessageAlertDialog(context, () => setState(onCancelMessageWrite));
          return false;
        }
        return true;
      },
      child: Stack(children: [
        ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: SingleChildScrollView(
              reverse: true,
              child: widget.contentWidget,
            )),
        Column(
          children: [
            const Spacer(),
            Container(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(color: AppColors.white, width: 1))),
              child: TextFormField(
                  focusNode: writeMessageFocusNode,
                  controller: writeMessageController,
                  style: TextStyle(
                      fontSize: 14, color: AppColors.greyishBrown, height: 1.5),
                  onChanged: (text) {
                    setState(() {});
                  },
                  keyboardType: TextInputType.multiline,
                  autofocus: false,
                  minLines: 1,
                  maxLines: 3,
                  decoration: InputDecoration(
                      enabled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.veryLightPink,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      suffixIcon: Container(
                          padding: const EdgeInsets.only(right: 15),
                          color: Colors.transparent,
                          child: Buttons.textButton(
                              text: "보내기",
                              color: writeMessageController.text.isNotEmpty
                                  ? AppColors.mediumPink
                                  : AppColors.veryLightPink,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              onTap: writeMessageController.text.isNotEmpty
                                  ? () {
                                      widget.onCompleteWriteMessage(
                                          writeMessageController.text);
                                      writeMessageController.clear();
                                    }
                                  : null)),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.veryLightPink,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.mediumPink,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      hintText: "메시지를 입력하세요",
                      hintStyle: TextStyle(
                          fontSize: 14, color: AppColors.veryLightPink))),
            )
          ],
        )
      ]),
    );
  }

  void onCancelMessageWrite() {
    writeMessageController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void showMessageAlertDialog(BuildContext context, void Function() onCancel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CheckMessageCancelDialog(onCancel: onCancel);
        });
  }
}
