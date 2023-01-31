class BookmarkFolderItem {
  final int folderId;
  String folderName;
  final String lastItemThumbUrl;
  bool isSecret;

  BookmarkFolderItem(
      {required this.folderId,
      required this.folderName,
      required this.lastItemThumbUrl,
      required this.isSecret});
}
