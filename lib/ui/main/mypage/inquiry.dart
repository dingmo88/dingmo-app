import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/ui/main/mypage/widgets/inquiry_history_tab.dart';
import 'package:dingmo/ui/main/mypage/widgets/inquiry_write_tab.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../utils/scroll_behavior.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {
      safePrint(tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(
        context,
        title: "1:1 문의",
        bottom: TabBar(
          controller: tabController,
          indicatorColor: AppColors.greyishBrown,
          labelStyle: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
          unselectedLabelStyle: TextStyle(
              fontSize: 13, color: AppColors.greyishBrown.withOpacity(0.6)),
          labelColor: AppColors.greyishBrown,
          tabs: const [
            Tab(
              text: "문의하기",
            ),
            Tab(
              text: "나의 문의 내역",
            ),
          ],
        ),
      ),
      body: ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: TabBarView(
            controller: tabController,
            children: const [
              InquiryWriteTab(),
              InquiryHistoryTab(),
            ],
          )),
    );
  }
}
