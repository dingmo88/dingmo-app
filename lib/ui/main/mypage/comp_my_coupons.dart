import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/ui/main/mypage/widgets/comp_coupon_used_user_tab.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../widgets/texts.dart';
import 'widgets/comp_my_coupons_tab.dart';

class CompMyCouponsPage extends StatefulWidget {
  const CompMyCouponsPage({Key? key}) : super(key: key);

  @override
  State<CompMyCouponsPage> createState() => _CompMyCouponsPageState();
}

class _CompMyCouponsPageState extends State<CompMyCouponsPage>
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Texts.defaultText(
              text: "쿠폰 사용 확인", fontSize: 16, fontWeight: FontWeight.bold),
          bottom: TabBar(
            controller: tabController,
            indicatorColor: AppColors.greyishBrown,
            labelStyle: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
            unselectedLabelStyle: TextStyle(
                fontSize: 13, color: AppColors.greyishBrown.withOpacity(0.6)),
            labelColor: AppColors.greyishBrown,
            tabs: const [
              Tab(
                text: "내 발행 쿠폰",
              ),
              Tab(
                text: "사용 완료",
              ),
            ],
          ),
        ),
        body: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: TabBarView(
              controller: tabController,
              children: const [
                CompMyCouponTab(),
                CouponUsedUserTab(),
              ],
            )),
      ),
    );
  }
}
