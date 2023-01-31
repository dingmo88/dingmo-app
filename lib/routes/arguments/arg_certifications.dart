import 'package:dingmo/api/api_third_party.dart';

class CertificationsArgs {
  final void Function(PostCertPersonResult? result) onComplete;

  CertificationsArgs({required this.onComplete});
}
