import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/items/comp_coupon_used_user_item.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

import 'comp_coupon_used_user_item.dart';

class CouponUsedUserTab extends StatefulWidget {
  const CouponUsedUserTab({Key? key}) : super(key: key);

  @override
  State<CouponUsedUserTab> createState() => _CompCouponUsedUserTabTabState();
}

class _CompCouponUsedUserTabTabState extends State<CouponUsedUserTab>
    with AutomaticKeepAliveClientMixin<CouponUsedUserTab> {
  late final Future<void> loadCouponListFuture;
  final List<CompCouponUsedUserItem> couponUsedUserList = [];

  @override
  void initState() {
    super.initState();

    loadCouponListFuture = loadCouponUsedUserList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.white,
      child: FutureBuilder(
        future: loadCouponListFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const DingmoProgressIndicator(size: 40);
          } else {
            return ListView.separated(
              shrinkWrap: true,
              itemCount: couponUsedUserList.length,
              itemBuilder: (BuildContext context, int index) => Padding(
                padding: EdgeInsets.only(
                    top: index == 0 ? 20 : 0,
                    bottom: index >= couponUsedUserList.length - 1 ? 40 : 0),
                child: CompCouponUsedUserItemWidget(
                    item: couponUsedUserList[index]),
              ),
              separatorBuilder: (BuildContext context, int index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 1,
                color: AppColors.white,
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> loadCouponUsedUserList() {
    return Future.delayed(const Duration(seconds: 1), () {
      for (int idx = 0; idx < 12; idx++) {
        couponUsedUserList.add(
          CompCouponUsedUserItem(
              profileUrl: "https://picsum.photos/id/${333 + idx}/105/105",
              nickname: "woori_wedding$idx",
              category: "예비신랑신부",
              dateUsed: "2021.05.19"),
        );
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
