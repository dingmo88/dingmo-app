import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_third_party.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:iamport_flutter/iamport_certification.dart';
import 'package:iamport_flutter/model/certification_data.dart';

class CertificationsPage extends StatelessWidget {
  final void Function(PostCertPersonResult? result) onComplete;
  const CertificationsPage({Key? key, required this.onComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      initialChild: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: AppColors.mediumPink,
        ),
      ),
      userCode: 'imp75012122',
      data: CertificationData(
        mRedirectUrl: "https://dev.dingmo.co.kr/api/exists/test",
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
        company: '(주)뉴니버스',
        carrier: 'KT',
        name: '안선재',
        phone: '01096266203',
      ),
      callback: (Map<String, String> result) {
        if (result['success'] == "true") {
          getIt<ApiThirdParty>()
              .certPerson(
                  PostCertPersonRequest(impUid: result['imp_uid'] as String))
              .then((response) => done(context, response.result))
              .catchError((e) {
            safePrint("exception: $e");
            failed(context);
          });
        } else {
          failed(context);
        }
      },
    );
  }

  void failed(context) {
    Fluttertoast.showToast(msg: "인증에 문제가 발생하였습니다.");
    onComplete(null);
    Navigator.pop(context);
  }

  void done(context, PostCertPersonResult result) {
    safePrint("cert result: ${result.toJson()}");

    onComplete(result);
    Navigator.pop(context, true);
  }
}
