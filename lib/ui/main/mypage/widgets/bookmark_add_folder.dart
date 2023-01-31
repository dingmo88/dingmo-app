import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/widgets/input_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BookmarkAddFolderWidget extends StatefulWidget {
  final void Function(PostBmkFolderResult newFolder) onAddCompleted;
  const BookmarkAddFolderWidget({Key? key, required this.onAddCompleted})
      : super(key: key);

  @override
  State<BookmarkAddFolderWidget> createState() =>
      _BookmarkAddFolderWidgetState();
}

class _BookmarkAddFolderWidgetState extends State<BookmarkAddFolderWidget> {
  FocusNode folderNameFocusNode = FocusNode();
  TextEditingController folderNameController = TextEditingController();

  String _folderName = "";
  bool _isSecret = false;

  bool _isLoading = false;

  Future<PostBmkFolderResult?> _addFolder() async {
    try {
      return (await getIt<ApiBmkFolder>().create(PostBmkFolderRequest(
              folderName: _folderName, isSecret: _isSecret)))
          .result;
    } catch (e) {
      safePrint("exception: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isLoading;
      },
      child: IgnorePointer(
          ignoring: _isLoading,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
                color: Colors.transparent,
                child: Wrap(children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        color: Colors.transparent,
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("폴더 추가",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.greyishBrown,
                                            fontWeight: FontWeight.bold)),
                                    GestureDetector(
                                      onTap: () => setState(
                                          () => _isSecret = !_isSecret),
                                      child: Container(
                                          width: 60,
                                          color: Colors.transparent,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                _isSecret
                                                    ? "assets/mypage/lock_icon.svg"
                                                    : "assets/mypage/unlock_icon.svg",
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                _isSecret ? "비공개" : "공개",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: _isSecret
                                                        ? AppColors.mediumPink
                                                        : AppColors
                                                            .veryLightPink),
                                              )
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Container(
                                    child: InputForms.textInputForm(
                                  folderNameFocusNode,
                                  folderNameController,
                                  (text) => setState(() => _folderName = text),
                                  hint: "폴더명을 입력해주세요.",
                                )),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Flexible(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.veryLightPink,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                            ),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: const Center(
                                                  child: Text(
                                                "취소",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )),
                                            ))),
                                    const SizedBox(width: 20),
                                    Flexible(
                                        child: ElevatedButton(
                                            onPressed: () async {
                                              FocusScope.of(context).unfocus();
                                              if (_folderName.isNotEmpty) {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                final newFolder =
                                                    await _addFolder();

                                                setState(() {
                                                  _isLoading = true;
                                                });

                                                if (newFolder != null) {
                                                  pop();
                                                  widget.onAddCompleted(
                                                      newFolder);
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "문제가 발생하였습니다");
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: AppColors.mediumPink,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24),
                                              ),
                                            ),
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20),
                                              child: const Center(
                                                  child: Text(
                                                "확인",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white),
                                              )),
                                            ))),
                                  ],
                                )
                              ],
                            )),
                      ),
                      Visibility(
                          visible: _isLoading,
                          child: Container(
                            padding: const EdgeInsets.only(top: 50),
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.mediumPink,
                            ),
                          ))
                    ],
                  )
                ])),
          )),
    );
  }

  void pop() {
    Navigator.pop(context);
  }
}
