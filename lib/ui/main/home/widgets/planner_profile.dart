import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/routes/arguments/arg_plan_profile.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/home/items/planner_profile_item.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/texts.dart';

class HomeTabPlannerProfileWidget extends StatefulWidget {
  final HomeTabPlannerProfileItem profileItem;
  const HomeTabPlannerProfileWidget({Key? key, required this.profileItem})
      : super(key: key);

  @override
  State<HomeTabPlannerProfileWidget> createState() =>
      _HomeTabPlannerProfileWidgetState();
}

class _HomeTabPlannerProfileWidgetState
    extends State<HomeTabPlannerProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.planProfile,
            arguments:
                PlanProfileArgs(profileId: widget.profileItem.profileId));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              width: MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.width * 0.16,
              decoration: BoxDecoration(
                  color: AppColors.greyWhite,
                  border: Border.all(color: AppColors.greyWhite, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                    imageUrl: widget.profileItem.profileUrl,
                    fit: BoxFit.cover,
                    errorWidget: (context, exception, stackTrace) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/dingmo.png",
                        ),
                      );
                    }),
              )),
          const SizedBox(height: 10),
          Texts.defaultText(text: widget.profileItem.nickname, fontSize: 13)
        ]),
      ),
    );
  }
}
