import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/picto_item.dart';

class CompEditPictoArgs {
  final List<PictoItem<CompProfilePictorial>> initPictos;
  final void Function(List<PictoItem<CompProfilePictorial>> pictos)
      onPictoSelected;

  CompEditPictoArgs({
    required this.initPictos,
    required this.onPictoSelected,
  });
}
