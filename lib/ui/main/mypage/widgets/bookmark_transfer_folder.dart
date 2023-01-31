import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../../widgets/loading.dart';

class BookmarkTransferFolderWidget extends StatelessWidget {
  final void Function(String folderName) onFolderSelected;
  final Future<List<String>> getFolderNames;

  const BookmarkTransferFolderWidget(
      {Key? key, required this.onFolderSelected, required this.getFolderNames})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.4,
      initialChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return FutureBuilder<List<String>>(
            future: getFolderNames,
            builder: ((context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SizedBox(
                  height: 300,
                  child: DingmoProgressIndicator(size: 2),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Texts.defaultText(
                              text: "지역 선택",
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
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
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: NoGlowBehavior(),
                        child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: [
                            ...(snapshot.data!
                                .map((areaName) => TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      onFolderSelected(areaName);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        areaName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.greyishBrown),
                                      ),
                                    )))
                                .toList())
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            }));
      },
    );
  }
}
