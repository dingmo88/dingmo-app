import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBars {
  static AppBar lightDefaultAppBar(BuildContext context,
      {String? title,
      VoidFunc? onClose,
      Widget? action,
      PreferredSizeWidget? bottom,
      bool closeEnabled = true}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      title: title != null
          ? Texts.defaultText(
              text: title, fontSize: 16, fontWeight: FontWeight.bold)
          : Container(),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: closeEnabled == true
            ? onClose ?? () => Navigator.of(context).pop()
            : null,
      ),
      actions: [action ?? Container()],
      bottom: bottom,
    );
  }

  static AppBar defaultAppBar(BuildContext context,
      {String? title,
      VoidFunc? onClose,
      Widget? action,
      PreferredSizeWidget? bottom,
      bool closeEnabled = true}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: title != null
          ? Texts.defaultText(
              text: title, fontSize: 16, fontWeight: FontWeight.bold)
          : Container(),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: closeEnabled == true
            ? onClose ?? () => Navigator.of(context).pop()
            : null,
      ),
      actions: [action ?? Container()],
      bottom: bottom,
    );
  }

  static AppBar titleWidgetAppBar(BuildContext context,
      {required Widget title,
      VoidFunc? onClose,
      Widget? action,
      PreferredSizeWidget? bottom}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: title,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: onClose ?? () => Navigator.of(context).pop(),
      ),
      actions: [action ?? Container()],
      bottom: bottom,
    );
  }

  static AppBar closableAppBar(BuildContext context,
      {String? title, VoidFunc? onClose, Widget? action}) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: title != null
          ? Texts.defaultText(
              text: title, fontSize: 16, fontWeight: FontWeight.bold)
          : Container(),
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: onClose ?? () => Navigator.of(context).pop(),
      ),
      actions: [action ?? Container()],
    );
  }
}
