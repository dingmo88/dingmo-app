import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/commons/widgets/reels_view/reels_view.dart';
import 'package:dingmo/ui/widgets/light_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SingleReelsPage extends StatefulWidget {
  final int contentId;
  const SingleReelsPage({Key? key, required this.contentId}) : super(key: key);

  @override
  State<SingleReelsPage> createState() => _SingleReelsPageState();
}

class _SingleReelsPageState extends State<SingleReelsPage> {
  late final Future<GetShortsResult?> _getReelsFuture;

  @override
  void initState() {
    super.initState();

    _getReelsFuture = _getReels();
    _getReelsFuture.then((result) {
      if (result == null) {
        Fluttertoast.showToast(msg: "잘못된 접근입니다");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LightStatusBarWidget(
      isLightIcon: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ReelsView(
          isInSingle: true,
          reelsItemFuture: _getReelsFuture,
          playOnReady: true,
          onReelsUpdated: () {
            Navigator.pushNamed(context, Routes.singleReels,
                    arguments: SingleReelsArgs(contentId: widget.contentId))
                .then((value) => Navigator.pop(context, true));
          },
        ),
      ),
    );
  }

  Future<GetShortsResult?> _getReels() async {
    try {
      final response = getIt<MemberInfo>().isGuest()
          ? await getIt<ApiShorts>()
              .getGuest(GetShortsRequest(contentId: widget.contentId))
          : await getIt<ApiShorts>()
              .get(GetShortsRequest(contentId: widget.contentId));
      return response.result;
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }
}
