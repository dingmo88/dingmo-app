import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';

class MainPictoSelectWidget extends StatelessWidget {
  final void Function(int priority) onSelect;
  final void Function() onDelete;
  const MainPictoSelectWidget(
      {Key? key, required this.onSelect, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.defaultText(
                    text: "사진 선택", fontSize: 16, fontWeight: FontWeight.bold),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  iconSize: 20,
                )
              ],
            ),
          ),
          SelectOptionButton(name: '메인1 사진으로 지정', onTap: () => onSelect(1)),
          SelectOptionButton(name: '메인2 사진으로 지정', onTap: () => onSelect(2)),
          SelectOptionButton(name: '메인3 사진으로 지정', onTap: () => onSelect(3)),
          SelectOptionButton(name: '메인4 사진으로 지정', onTap: () => onSelect(4)),
          SelectOptionButton(
            name: '사진 삭제',
            onTap: onDelete,
          ),
        ],
      ),
    );
  }
}

class SelectOptionButton extends StatelessWidget {
  final String name;
  final void Function() onTap;
  const SelectOptionButton({Key? key, required this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap,
        child: Container(
          width: double.infinity,
          color: Colors.transparent,
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Text(
            name,
            style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
          ),
        ));
  }
}
