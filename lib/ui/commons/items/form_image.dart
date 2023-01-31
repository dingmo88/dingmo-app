import 'dart:io';

class FormImage<Item> {
  late final Item? _item;
  late final File? _imgFile;
  final String Function() imgKey;
  final String Function()? thumbKey;
  final String Function() id;

  FormImage._internal(
      this._item, this._imgFile, this.id, this.imgKey, this.thumbKey);

  factory FormImage.from(
      Item item, String Function() id, String Function() imgKey,
      {String Function()? thumbKey}) {
    return FormImage._internal(item, null, id, imgKey, thumbKey);
  }

  factory FormImage.fromFile(File imgFile, String Function() id) {
    return FormImage._internal(null, imgFile, id, () => "", null);
  }

  bool isItem() => _item != null;
  Item item() => _item!;

  bool isFile() => _imgFile != null;
  File file() => _imgFile!;
}
