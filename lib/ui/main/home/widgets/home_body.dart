import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/routes/arguments/arg_search_profiles.dart';
import 'package:dingmo/ui/main/home/items/main_tagdata_item.dart';
import 'package:dingmo/ui/main/home/items/planner_profile_item.dart';
import 'package:dingmo/ui/main/home/widgets/main_tagdata.dart';
import 'package:dingmo/ui/main/home/widgets/planner_profile.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;

import '../items/home_contents_item.dart';
import 'home_category.dart';

class HomeTabBodyWidget extends StatefulWidget {
  final GetHomeResult result;
  const HomeTabBodyWidget({Key? key, required this.result}) : super(key: key);

  @override
  State<HomeTabBodyWidget> createState() => _HomeTabBodyWidgetState();
}

class _HomeTabBodyWidgetState extends State<HomeTabBodyWidget> {
  late final HomeTabContentsItem item;

  @override
  void initState() {
    super.initState();

    item = getHomeContents();
  }

  HomeTabContentsItem getHomeContents() {
    return HomeTabContentsItem(
        plannerProfileItems: widget.result.planners
            .map((e) => HomeTabPlannerProfileItem(
                profileId: e.profileId,
                nickname: e.nickname,
                profileUrl: path.join(Endpoints.imgUrl, e.profileImgKey)))
            .toList(),
        mainTagItems: widget.result.contents
            .map((e) => MainTagDataItem(
                idxTag: e.idxTag,
                title: idxTagToString(valueToIdxTag(e.idxTag)),
                contents: e.contents
                    .map((e) => MainTagContentItem(
                        contentId: e.contentId,
                        title: e.summary,
                        type: valueToCtType(e.contentType)!,
                        thumbnailUrl: path.join(Endpoints.imgUrl, e.thumbKey),
                        viewCount: e.viewCnt))
                    .toList()))
            .toList()
            .where((e) => e.contents.isNotEmpty)
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Routes.search);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.veryLightPink, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "궁금한 웨딩정보를 검색해보세요",
                    style:
                        TextStyle(fontSize: 14, color: AppColors.veryLightPink),
                  ),
                  SvgPicture.asset("assets/home/search_icon.svg")
                ]),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeCategoryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.searchProfiles,
                          arguments: SearchProfilesArgs(
                              memberType: MemberType.comp,
                              idxTag: IdxTag.weddHole));
                    },
                    assetUrl: "assets/home/wedding_icon.svg",
                    name: "웨딩홀"),
                HomeCategoryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.searchProfiles,
                          arguments: SearchProfilesArgs(
                              memberType: MemberType.comp,
                              idxTag: IdxTag.studio));
                    },
                    assetUrl: "assets/home/studio_icon.svg",
                    name: "스튜디오"),
                HomeCategoryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.searchProfiles,
                          arguments: SearchProfilesArgs(
                              memberType: MemberType.comp,
                              idxTag: IdxTag.dress));
                    },
                    assetUrl: "assets/home/dress_icon.svg",
                    name: "드레스"),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeCategoryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.searchProfiles,
                          arguments: SearchProfilesArgs(
                              memberType: MemberType.comp,
                              idxTag: IdxTag.makeup));
                    },
                    assetUrl: "assets/home/makeup_icon.svg",
                    name: "메이크업"),
                HomeCategoryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.searchProfiles,
                          arguments: SearchProfilesArgs(
                              memberType: MemberType.comp,
                              idxTag: IdxTag.coma));
                    },
                    assetUrl: "assets/home/bed_icon.svg",
                    name: "혼수"),
                HomeCategoryButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.searchProfiles,
                          arguments: SearchProfilesArgs(
                              memberType: MemberType.comp, idxTag: IdxTag.etc));
                    },
                    assetUrl: "assets/home/etc_icon.svg",
                    name: "기타"),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          color: const Color(0xFFf8f8f8),
          width: double.infinity,
          height: 4,
        ),
        const SizedBox(height: 28),
        Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.defaultText(
                    text: "이달의 플래너 ✨",
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.searchProfiles,
                        arguments:
                            SearchProfilesArgs(memberType: MemberType.plan));
                  },
                  child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: SvgPicture.asset("assets/home/right_icon.svg")),
                )
              ],
            )),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.topLeft,
          height: MediaQuery.of(context).size.width * 0.16 * (93 / 58),
          child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: item.plannerProfileItems.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                    child: HomeTabPlannerProfileWidget(
                        profileItem: item.plannerProfileItems[index]),
                  );
                },
              )),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: item.mainTagItems.length,
            itemBuilder: ((context, index) {
              return HomeTabMainTagDataWidget(
                  mainTagData: item.mainTagItems[index]);
            })),
        const SizedBox(height: 40),
      ],
    );
  }
}
