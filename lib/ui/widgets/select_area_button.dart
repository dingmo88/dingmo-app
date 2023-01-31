import 'package:dingmo/api/api_area.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';
import 'select_area_sheet.dart';

class SelectAreaButton extends StatefulWidget {
  final String? initArea1;
  final String? initArea2;
  final void Function(GetAreaResult area1, GetAreaResult area2) onAreaSelected;
  const SelectAreaButton(
      {Key? key,
      required this.initArea1,
      required this.initArea2,
      required this.onAreaSelected})
      : super(key: key);

  @override
  State<SelectAreaButton> createState() => _SelectAreaButtonState();
}

class _SelectAreaButtonState extends State<SelectAreaButton> {
  late String areaDisplayText;

  @override
  void initState() {
    super.initState();

    areaDisplayText = getAreaDisplyText(widget.initArea1, widget.initArea2);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showArea1InfoSheet(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.veryLightPink, width: 1)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            areaDisplayText,
            style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
          ),
          SvgPicture.asset("assets/mypage/caret_down_icon.svg")
        ]),
      ),
    );
  }

  void showArea1InfoSheet(BuildContext context) {
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
        getAreas: getAreas1(),
        onAreaSelected: (area) {
          showArea2InfoSheet(context, area);
        },
      ),
    );
  }

  void showArea2InfoSheet(BuildContext context, GetAreaResult area1) {
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
          setState(() {
            areaDisplayText = getAreaDisplyText(area1.areaName, area2.areaName);
          });
          widget.onAreaSelected(area1, area2);
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
}
