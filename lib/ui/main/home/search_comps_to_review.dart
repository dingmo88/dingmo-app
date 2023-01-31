import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/upload/feeds/items/search_mention.dart';
import 'package:dingmo/ui/upload/feeds/widgets/search_mention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/input_forms.dart';

class SearchCompsForReviewPage extends StatefulWidget {
  const SearchCompsForReviewPage({Key? key}) : super(key: key);

  @override
  State<SearchCompsForReviewPage> createState() =>
      _SearchCompsForReviewPageState();
}

class _SearchCompsForReviewPageState extends State<SearchCompsForReviewPage> {
  final FocusNode searchMentionNode = FocusNode();
  final TextEditingController searchMentionController = TextEditingController();

  Future<void> searchMentionFuture = Future.value();
  final List<SearchMentionItem> searchedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 20),
          Container(
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
                      searchMentionNode,
                      searchMentionController,
                      (text) {
                        setState(() {});
                      },
                      hint: "후기 작성할 업체를 검색해보세요",
                      suffixIcon: GestureDetector(
                          onTap: searchMentionController.text.isNotEmpty
                              ? () => setState(
                                  () => searchMentionController.clear())
                              : null,
                          child: Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(12),
                            child: searchMentionController.text.isNotEmpty
                                ? SvgPicture.asset(
                                    "assets/home/tag_delete_icon.svg",
                                  )
                                : SvgPicture.asset(
                                    "assets/home/search_icon.svg",
                                  ),
                          )),
                      onSubmitted: (text) {
                        setState(() {
                          searchMentionFuture = searchMention();
                        });
                      }),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: searchMentionFuture,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: AppColors.mediumPink),
                  );
                } else {
                  return ListView.builder(
                    itemCount: searchedItems.length,
                    itemBuilder: (BuildContext context, int index) =>
                        SearchMentionItemWidget(
                            item: searchedItems[index],
                            onPressed: () => Navigator.pushNamed(
                                context, Routes.compProfile)),
                  );
                }
              },
            ),
          )
        ]),
      ),
    );
  }

  Future<void> searchMention() {
    return Future.delayed(const Duration(seconds: 1), () {
      for (int idx = 0; idx < 10; idx++) {
        searchedItems.add(
          SearchMentionItem(
              profileUrl: "https://picsum.photos/id/${237 + idx}/105/105",
              nickname: "woori_wedding${idx + 1}",
              categoryName:
                  idx % 2 == 0 ? "웨딩플래너${idx + 1}" : "웨딩업체${idx + 1}"),
        );
      }
    });
  }
}
