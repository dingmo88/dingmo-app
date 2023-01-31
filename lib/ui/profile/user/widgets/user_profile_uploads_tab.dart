import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

import '../../../../routes/routes.dart';
import '../items/user_profile_content_item.dart';

class UserProfileUploadsTab extends StatefulWidget {
  final List<UserProfileContentItem> contents;
  final bool isLastUploadsLoaded;
  const UserProfileUploadsTab(
      {Key? key, required this.contents, required this.isLastUploadsLoaded})
      : super(key: key);

  @override
  State<UserProfileUploadsTab> createState() => _UserProfileUploadsTabState();
}

class _UserProfileUploadsTabState extends State<UserProfileUploadsTab> {
  final int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: widget.contents
                .map((content) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.viewFeedItem,
                            arguments: ViewFeedItemArgs(contentId: 0));
                      },
                      child: Container(
                        color: AppColors.greyWhite,
                        child: CachedNetworkImage(
                          imageUrl: content.thumbUrl,
                          errorWidget: ((context, error, stackTrace) =>
                              Container()),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Visibility(
              visible: !widget.isLastUploadsLoaded,
              child: const DingmoProgressIndicator(
                  size: 40, margin: EdgeInsets.symmetric(vertical: 20))),
          Visibility(
              visible: widget.isLastUploadsLoaded,
              child: const SizedBox(
                height: 40,
              )),
        ],
      ),
    );
  }
}
