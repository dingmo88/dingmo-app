import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchRecentsItemWidget extends StatelessWidget {
  final String keyword;
  final void Function() onPressed;
  final void Function() onDelete;
  const SearchRecentsItemWidget(
      {Key? key,
      required this.keyword,
      required this.onPressed,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.only(left: 20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                keyword,
                style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
              ),
              GestureDetector(
                onTap: onDelete,
                child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                        left: 20, top: 20, bottom: 20, right: 20),
                    child: Icon(
                      Icons.close,
                      color: AppColors.greyishBrown,
                      size: 16,
                    )),
              )
            ]),
      ),
    );
  }
}
