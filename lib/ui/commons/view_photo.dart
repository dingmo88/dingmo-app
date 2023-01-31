import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../widgets/page_indicator.dart';

class ViewPhotoPage extends StatefulWidget {
  final int initViewIdx;
  final List<ImageProvider> imageProviders;
  final bool checkComplete;
  final void Function(BuildContext context)? onPop;
  const ViewPhotoPage({
    Key? key,
    required this.initViewIdx,
    this.checkComplete = false,
    required this.imageProviders,
    this.onPop,
  }) : super(key: key);

  @override
  State<ViewPhotoPage> createState() => _ViewPhotoPageState();
}

class _ViewPhotoPageState extends State<ViewPhotoPage> {
  late final PageController controller;
  late int selectedIndex;

  @override
  void initState() {
    super.initState();

    controller = PageController(initialPage: widget.initViewIdx);
    selectedIndex = widget.initViewIdx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Column(children: [
              Expanded(
                  child: PageView.builder(
                      controller: controller,
                      itemCount: widget.imageProviders.length,
                      pageSnapping: true,
                      onPageChanged: (pageIndex) {
                        setState(() {
                          selectedIndex = pageIndex;
                        });
                      },
                      itemBuilder: (context, pageIndex) {
                        return Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.greyWhite,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.mediumPink,
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: widget.imageProviders[pageIndex],
                                      fit: BoxFit.cover)),
                            )
                          ],
                        );
                      })),
              const SizedBox(height: 10),
              Visibility(
                  visible: widget.imageProviders.length > 1,
                  maintainState: true,
                  child: PageIndicator(
                    size: 6,
                    spacing: 5,
                    selectedColor: AppColors.greyishBrown,
                    unselectedColor: AppColors.veryLightPink,
                    selectedIndex: selectedIndex,
                    itemCount: widget.imageProviders.length,
                  ))
            ]),
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            height: kToolbarHeight,
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => widget.onPop ?? Navigator.pop(context),
                ),
                widget.checkComplete
                    ? GestureDetector(
                        onTap: () => Navigator.pop(context, true),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Text(
                            "완료",
                            style: TextStyle(
                                color: AppColors.mediumPink,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    : Container()
              ],
            ))
      ],
    ));
  }
}
