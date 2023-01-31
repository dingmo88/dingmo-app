import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_my_bookmark_folder_details.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/mypage/items/bookmark_folder_item.dart';
import 'package:dingmo/ui/main/mypage/widgets/bookmark_folder.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import 'widgets/bookmark_add_folder.dart';

class MyBookmarksPage extends StatefulWidget {
  const MyBookmarksPage({Key? key}) : super(key: key);

  @override
  State<MyBookmarksPage> createState() => _MyBookmarksPageState();
}

class _MyBookmarksPageState extends State<MyBookmarksPage> {
  late final Future<void> getBookmarkFoldersFuture;

  final List<BookmarkFolderItem> bmkFolders = [];

  @override
  void initState() {
    super.initState();

    getBookmarkFoldersFuture = getBookmarkFolders().then((folders) {
      if (folders == null) {
        Fluttertoast.showToast(msg: "잘못된 접근입니다");
        Navigator.pop(context);
      } else {
        bmkFolders.addAll(folders);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "북마크"),
      body: SafeArea(
          child: FutureBuilder(
        future: getBookmarkFoldersFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              alignment: Alignment.center,
              height: 80,
              child: CircularProgressIndicator(
                color: AppColors.mediumPink,
                strokeWidth: 2,
              ),
            );
          } else {
            return ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: GridView.builder(
                    itemCount: bmkFolders.length + 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) => index == 0
                        ? BookmarkAddFolderButton(
                            onPressed: () => showAddBookmarkSheet())
                        : BookmarkFolderItemWidget(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.mybookmarkFolderDetails,
                                  arguments: MybookmarkFolderDetailsArgs(
                                      item: bmkFolders[index - 1],
                                      onFolderEdited: (newItem) {
                                        setState(() {
                                          bmkFolders[index - 1] = newItem;
                                        });
                                      },
                                      onFolderDeleted: () {
                                        setState(() {
                                          bmkFolders.removeAt(index - 1);
                                        });
                                      }));
                            },
                            item: bmkFolders[index - 1],
                          ),
                  )),
            );
          }
        },
      )),
    );
  }

  Future<List<BookmarkFolderItem>?> getBookmarkFolders() async {
    try {
      final result = (await getIt<ApiBmkFolder>().getList()).result;

      return result
          .map((e) => BookmarkFolderItem(
              folderId: e.foldId,
              folderName: e.foldName,
              lastItemThumbUrl: path.join(Endpoints.imgUrl, e.foldThumbKey),
              isSecret: e.isSecret))
          .toList();
    } catch (e) {
      safePrint(e);
    }

    return null;
  }

  void showAddBookmarkSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: false,
        builder: (builder) => BookmarkAddFolderWidget(
              onAddCompleted: (newFolder) {
                setState(() {
                  bmkFolders.insert(
                      0,
                      BookmarkFolderItem(
                          folderId: newFolder.foldId,
                          folderName: newFolder.foldName,
                          lastItemThumbUrl: path.join(
                              Endpoints.imgUrl, newFolder.foldThumbKey),
                          isSecret: newFolder.isSecret));
                });

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "폴더가 추가되었습니다.",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  ),
                  backgroundColor: Colors.black,
                ));
              },
            ));
  }
}
