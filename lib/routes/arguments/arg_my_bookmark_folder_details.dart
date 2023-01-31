import 'package:dingmo/ui/main/mypage/items/bookmark_folder_item.dart';

class MybookmarkFolderDetailsArgs {
  final BookmarkFolderItem item;
  final void Function(BookmarkFolderItem editedItem) onFolderEdited;
  final void Function() onFolderDeleted;

  MybookmarkFolderDetailsArgs({
    required this.item,
    required this.onFolderEdited,
    required this.onFolderDeleted,
  });
}
