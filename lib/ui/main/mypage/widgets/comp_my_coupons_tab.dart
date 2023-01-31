import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/items/my_coupon_item.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'my_coupon_item.dart';

class CompMyCouponTab extends StatefulWidget {
  const CompMyCouponTab({Key? key}) : super(key: key);

  @override
  State<CompMyCouponTab> createState() => _CompMyCouponTabState();
}

class _CompMyCouponTabState extends State<CompMyCouponTab>
    with AutomaticKeepAliveClientMixin<CompMyCouponTab> {
  late final Future<void> loadCouponListFuture;
  final List<MyCouponItem> couponList = [];

  @override
  void initState() {
    super.initState();

    loadCouponListFuture = loadCouponList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyWhite,
      child: FutureBuilder(
        future: loadCouponListFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const DingmoProgressIndicator(size: 40);
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: couponList.length,
                itemBuilder: (BuildContext context, int index) => Padding(
                      padding: EdgeInsets.only(
                          top: index == 0 ? 20 : 0,
                          bottom: index >= couponList.length - 1 ? 80 : 0),
                      child: MyCouponItemWidget(
                        item: couponList[index],
                      ),
                    ));
          }
        },
      ),
    );
  }

  Future<void> loadCouponList() {
    return Future.delayed(const Duration(seconds: 1), () {
      for (int idx = 0; idx < 5; idx++) {
        couponList.add(MyCouponItem(
            discount: 30000 + idx,
            dateUntil: DateFormat('yyyy.MM.dd').format(DateTime.now()
              ..add(
                const Duration(days: 5),
              )),
            from: "우리웨딩스튜디오",
            remainedDays: 5));
      }
    });
  }

  @override
  bool get wantKeepAlive => true;
}
