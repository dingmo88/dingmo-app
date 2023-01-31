import 'package:dingmo/ui/commons/items/form_image.dart';

class PictoItem<Item> {
  final FormImage<Item> data;
  late bool _isMain;
  late int _priority;

  PictoItem(this.data, bool isMain, int priority) {
    _isMain = isMain;
    _priority = priority;
  }

  bool setMain(bool isMain, int priority) {
    if (priority < 0) {
      return false;
    }

    if (!isMain && priority != 0) {
      return false;
    }

    _isMain = isMain;
    _priority = priority;

    return true;
  }

  bool get isMain => _isMain;
  int get priority => _priority;
}
