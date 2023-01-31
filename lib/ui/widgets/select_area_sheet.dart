import 'package:dingmo/api/api_area.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import 'loading.dart';
import 'texts.dart';

class SelectAreaSheet extends StatelessWidget {
  final GetAreaResult? initArea;
  final void Function(GetAreaResult area) onAreaSelected;
  final Future<List<GetAreaResult>?> getAreas;

  const SelectAreaSheet(
      {Key? key,
      this.initArea,
      required this.onAreaSelected,
      required this.getAreas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      minChildSize: 0.4,
      initialChildSize: 0.4,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return FutureBuilder<List<GetAreaResult>?>(
            future: getAreas,
            builder: ((context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SizedBox(
                  height: 300,
                  child: DingmoProgressIndicator(size: 2),
                );
              } else {
                return Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(left: 20, top: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Texts.defaultText(
                                text: "지역 선택",
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: SvgPicture.asset(
                                  "assets/home/right_icon.svg"),
                            ),
                            const SizedBox(width: 5),
                            Texts.defaultText(
                                text: initArea?.areaName ?? "전체",
                                fontSize: 14,
                                fontWeight: FontWeight.bold)
                          ]),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                            iconSize: 20,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: NoGlowBehavior(),
                        child: ListView(
                          controller: scrollController,
                          shrinkWrap: true,
                          children: [
                            ...((snapshot.data ?? [])
                                .map((area) => TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      onAreaSelected(area);
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      color: Colors.transparent,
                                      padding: const EdgeInsets.all(20),
                                      child: Text(
                                        area.areaName,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.greyishBrown),
                                      ),
                                    )))
                                .toList())
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
            }));
      },
    );
  }
}

void showAreaInfoSheet(
    BuildContext context,
    void Function(String areaText, GetAreaResult area1, GetAreaResult area2)
        onSelected) {
  showModalBottomSheet<void>(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    isScrollControlled: true,
    builder: (context) => SelectAreaSheet(
        onAreaSelected: (area) {
          showArea2InfoSheet(context, area, onSelected);
        },
        getAreas: getAreas1()),
  );
}

void showArea2InfoSheet(
    BuildContext context,
    GetAreaResult area1,
    void Function(String areaText, GetAreaResult area1, GetAreaResult area2)
        onSelected) {
  showModalBottomSheet<void>(
    backgroundColor: Colors.white,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    isScrollControlled: true,
    builder: (context) => SelectAreaSheet(
      initArea: area1,
      getAreas: getAreas2(area1),
      onAreaSelected: (area2) {
        onSelected(
            getAreaDisplyText(area1.areaName, area2.areaName), area1, area2);
      },
    ),
  );
}

String getAreaDisplyText(String? area1, String? area2) {
  if (area1 == null || area2 == null) {
    return "지역 선택";
  }

  return (area1 == "서울" && area2 != "전체") ? area2 : "$area1 $area2";
}

Future<List<GetAreaResult>> getAreas1() async {
  return (await getIt<ApiArea>().getAreaFirstList()).result;
}

Future<List<GetAreaResult>> getAreas2(GetAreaResult area1) async {
  return (await getIt<ApiArea>()
          .getAreaSecondList(GetAreaSecondRequest(area1Id: area1.areaId)))
      .result;
}
