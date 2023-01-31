import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/home/items/event_benner_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';

class HomeTabEventBannerListPage extends StatefulWidget {
  const HomeTabEventBannerListPage({Key? key}) : super(key: key);

  @override
  State<HomeTabEventBannerListPage> createState() =>
      _HomeTabEventBannerListPageState();
}

class _HomeTabEventBannerListPageState
    extends State<HomeTabEventBannerListPage> {
  late Future<List<HomeTabEventBannerItem>> eventBannersFuture;

  Future<List<HomeTabEventBannerItem>> getEventBanners() {
    return Future.delayed(const Duration(seconds: 1), () {
      return [
        HomeTabEventBannerItem(
          imgUrl: "https://picsum.photos/id/${330}/350/350",
        ),
        HomeTabEventBannerItem(
          imgUrl: "https://picsum.photos/id/${331}/350/350",
        ),
        HomeTabEventBannerItem(
          imgUrl: "https://picsum.photos/id/${332}/350/350",
        )
      ];
    });
  }

  @override
  void initState() {
    super.initState();

    eventBannersFuture = getEventBanners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "이벤트"),
      body: SafeArea(
          child: SingleChildScrollView(
              child: FutureBuilder(
                  future: eventBannersFuture,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          margin: const EdgeInsets.only(top: 40),
                          alignment: Alignment.topCenter,
                          child: CircularProgressIndicator(
                            color: AppColors.mediumPink,
                            strokeWidth: 2,
                          ));
                    }

                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        ...([1, 2, 3]
                            .map((e) => Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, bottom: 20),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff707070),
                                        width: 1),
                                  ),
                                  width: MediaQuery.of(context).size.width - 40,
                                  height:
                                      (MediaQuery.of(context).size.width - 40) *
                                          0.375,
                                ))
                            .toList())
                      ],
                    );
                  }))),
    );
  }
}
