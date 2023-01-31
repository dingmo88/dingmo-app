import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'search_recents_item.dart';

class SearchRecentsWidget extends StatefulWidget {
  final void Function(String keyword) onItemPressed;
  const SearchRecentsWidget({Key? key, required this.onItemPressed})
      : super(key: key);

  @override
  State<SearchRecentsWidget> createState() => _SearchRecentsWidgetState();
}

class _SearchRecentsWidgetState extends State<SearchRecentsWidget> {
  late final Future<List<GetSearchHistoryResult>> recentsFuture;

  @override
  void initState() {
    super.initState();
    recentsFuture = getRecents();
  }

  Future<List<GetSearchHistoryResult>> getRecents() async {
    if (getIt<MemberInfo>().isGuest()) {
      return [];
    }

    try {
      return (await getIt<ApiSearch>().getHistory()).result;
    } catch (e) {
      safePrint("exception: $e");
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GetSearchHistoryResult>>(
        future: recentsFuture,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          } else {
            final recents = snapshot.data!;

            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: recents
                        .map((recent) => SearchRecentsItemWidget(
                              keyword: recent.keyword,
                              onDelete: () async {
                                if (!await _deleteHistory(recent.historyId)) {
                                  Fluttertoast.showToast(msg: "문제가 발생하였습니다");
                                } else {
                                  setState(() {
                                    recents.remove(recent);
                                  });
                                }
                              },
                              onPressed: () {
                                widget.onItemPressed(recent.keyword);
                              },
                            ))
                        .toList()),
              ),
            );
          }
        }));
  }

  Future<bool> _deleteHistory(int historyId) async {
    try {
      await getIt<ApiSearch>()
          .deleteHistory(DeleteHistoryRequest(historyId: historyId));
      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }
}
