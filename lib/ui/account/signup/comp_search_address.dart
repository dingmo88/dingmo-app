import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_third_party.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/widgets/input_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CompSearchAddressPage extends StatefulWidget {
  const CompSearchAddressPage({Key? key}) : super(key: key);

  @override
  State<CompSearchAddressPage> createState() => _CompSearchAddressPageState();
}

class _CompSearchAddressPageState extends State<CompSearchAddressPage> {
  bool _isSearching = false;
  bool _isNoSearchResult = false;

  final List<GetSearchAddressInfo> _addrInfoList = [];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _isSearching,
      child: Scaffold(
        body: SafeArea(
            child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  automaticallyImplyLeading: false,
                  title: AddresssSearchWidget(
                    hint: "주소 검색",
                    onSubmit: (String text) async {
                      setStateLoading(true);
                      final addrList = await search(text);
                      if (addrList != null) {
                        _addrInfoList.clear();
                        _isNoSearchResult = addrList.isEmpty;

                        if (!_isNoSearchResult) {
                          _addrInfoList.addAll(addrList);
                        }
                      }
                      setStateLoading(false);
                    },
                  ),
                  pinned: true,
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: _addrInfoList.length,
                  (context, index) {
                    return AddressInfoWidget(
                        addrInfo: _addrInfoList[index],
                        onPressed: () {
                          Navigator.pop(context, _addrInfoList[index]);
                        });
                  },
                )),
              ],
            ),
            Visibility(
                visible: _isSearching,
                child: Container(
                  margin: const EdgeInsets.only(top: 120),
                  alignment: Alignment.topCenter,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.mediumPink,
                  ),
                )),
            Visibility(
                visible: _isNoSearchResult,
                child: Container(
                  margin: const EdgeInsets.only(top: 80, left: 20),
                  alignment: Alignment.topLeft,
                  child: const Text("검색결과가 없습니다."),
                ))
          ],
        )),
      ),
    );
  }

  void setStateLoading(bool isLoading) {
    setState(() {
      _isSearching = isLoading;
    });
  }

  Future<List<GetSearchAddressInfo>?> search(String text) async {
    try {
      return (await getIt<ApiThirdParty>()
              .searchAddress(GetSearchAddressRequest(address: text)))
          .result;
    } catch (e) {
      safePrint("exception: $e");
      Fluttertoast.showToast(msg: "검색에 실패하였습니다");
      return null;
    }
  }
}

class AddressInfoWidget extends StatelessWidget {
  final GetSearchAddressInfo addrInfo;
  final void Function() onPressed;
  const AddressInfoWidget(
      {Key? key, required this.addrInfo, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1, color: AppColors.veryLightPink))),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            addrInfo.roadAddress,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(
            addrInfo.jibunAddress,
            style: const TextStyle(fontSize: 14),
          )
        ]),
      ),
    );
  }
}

class AddresssSearchWidget extends StatefulWidget {
  final String hint;
  final void Function(String text) onSubmit;
  const AddresssSearchWidget(
      {Key? key, required this.hint, required this.onSubmit})
      : super(key: key);

  @override
  State<AddresssSearchWidget> createState() => _AddresssSearchWidgetState();
}

class _AddresssSearchWidgetState extends State<AddresssSearchWidget> {
  FocusNode searchAddrFocusNode = FocusNode();
  TextEditingController searchAddrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InputForms.textInputForm(
          searchAddrFocusNode, searchAddrController, (text) {},
          hint: widget.hint,
          suffixIcon: GestureDetector(
              onTap: searchAddrController.text.isNotEmpty
                  ? () => setState(() => searchAddrController.clear())
                  : () {},
              child: Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(12),
                child: searchAddrController.text.isNotEmpty
                    ? SvgPicture.asset(
                        "assets/home/tag_delete_icon.svg",
                      )
                    : SvgPicture.asset(
                        "assets/home/search_icon.svg",
                      ),
              )),
          onSubmitted: widget.onSubmit),
    );
  }
}
