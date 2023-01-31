import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dingmo/api/api_exists.dart';
import 'package:dingmo/api/api_sign.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/social_type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/third_party/aws_amplify.dart';
import 'package:dingmo/third_party/kakao_login.dart';
import 'package:dingmo/ui/account/signup/form/signup_form.dart';
import 'package:dingmo/constants/signup_type_enum.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:rxdart/subjects.dart';

enum SendRecovEmailResult { failed, error, limited, malformed, success }

enum AuthSignUpResult { failedVerify, invaildVerifyCode, error, success }

enum LoginResult { failed, error, success }

enum ConfirmResetPassResult { failed, error, success, limited }

enum ExistEmailResult { yes, no, error }

enum AuthState { guest, loggedIn }

class AuthManager {
  final _amplify = getIt<AwsAmplify>();
  final _apiSign = getIt<ApiSign>();
  final _apiExists = getIt<ApiExists>();

  final _authStateSubject = PublishSubject<AuthState>();

  Stream<AuthState> get authState => _authStateSubject.stream;

  Future<void> signOut() async {
    await _amplify.signOut();
    await clearMemberInfo();
    await resetApiAndAuth();
  }

  Future<bool> resignWithSignOut() async {
    try {
      if (getIt<MemberInfo>().socialType == SocialType.kakao) {
        await kakaoUnlink();
      }

      await _amplify.deleteUser();
      await _apiSign.resign();
      await signOut();
    } catch (e) {
      safePrint(
          "debug! exception? $e, exception-accessToken: ${getIt<MemberInfo>().accessToken}");
      return false;
    }

    return true;
  }

  Future<PostEmailExistsResult?> existsEmail(String email) async {
    try {
      final result =
          await _apiExists.email(PostEmailExistsRequest(email: email));

      return result.result;
    } catch (e) {
      return null;
    }
  }

  Future<AmpResState> sendVerificationEmail(
      AuthCredentials authCredentials) async {
    return _amplify.signUpWithCredentials(authCredentials);
  }

  Future<AmpResState> changePassword(String oldPass, String newPass) async {
    return await _amplify.updatePassword(oldPass, newPass);
  }

  Future<ConfirmResetPassResult> confirmResetPassword(
      AuthCredentials authCredentials, String verificationCode) async {
    final confirmResult =
        await _amplify.confirmResetPassword(authCredentials, verificationCode);
    if (confirmResult == AmpResState.no) {
      return ConfirmResetPassResult.failed;
    } else if (confirmResult == AmpResState.yes) {
      return ConfirmResetPassResult.success;
    } else if (confirmResult == AmpResState.limited) {
      return ConfirmResetPassResult.limited;
    } else {
      return ConfirmResetPassResult.error;
    }
  }

  Future<LoginResult> login(AuthCredentials credentials) async {
    final loginResult = await _amplify.loginWithCredentials(credentials);

    if (loginResult == AmpResState.yes) {
      try {
        final response = await _apiSign.login(
            PostLoginRequest(ampUid: (await _amplify.getCurrentUser()).userId));

        final memberType = valueToMemberType(response.result.memberType);

        final socialType = valueToSocialType(response.result.socialType);

        if (memberType == null) {
          return LoginResult.failed;
        }

        await setMemberInfo(MemberInfo(
            accessToken: response.result.accessToken,
            memberType: memberType,
            socialType: socialType));
        await resetApiAndAuth();

        _authStateSubject.sink.add(AuthState.loggedIn);
        return LoginResult.success;
      } catch (e) {
        safePrint("exception: $e");
        await signOut();
        return LoginResult.error;
      }
    } else {
      return loginResult == AmpResState.no
          ? LoginResult.failed
          : LoginResult.error;
    }
  }

  Future<SendRecovEmailResult> sendRecoveryEmail(String email) async {
    final sendRecovState = (await _amplify.sendRecoveryCode(email));
    if (sendRecovState == AmpResState.yes) {
      return SendRecovEmailResult.success;
    } else if (sendRecovState == AmpResState.no) {
      return SendRecovEmailResult.failed;
    } else if (sendRecovState == AmpResState.error) {
      return SendRecovEmailResult.error;
    } else if (sendRecovState == AmpResState.limited) {
      return SendRecovEmailResult.limited;
    } else {
      return SendRecovEmailResult.malformed;
    }
  }

  Future<AuthSignUpResult> signUpWithLogin(
      SignUpForm form, String verificationCode) async {
    if (verificationCode.isEmpty) {
      return AuthSignUpResult.invaildVerifyCode;
    }

    final authCredentials =
        AuthCredentials(email: form.email!, password: form.password!);

    final isVerified =
        await _amplify.verifyCode(authCredentials, verificationCode);

    if (isVerified == AmpResState.error) {
      return AuthSignUpResult.failedVerify;
    } else if (isVerified == AmpResState.no) {
      return AuthSignUpResult.invaildVerifyCode;
    } else {
      await _amplify.loginWithCredentials(authCredentials);

      safePrint("amp uid: ${(await _amplify.getCurrentUser()).userId}");

      final apiSignUpResult =
          await _apiSignUp(form, (await _amplify.getCurrentUser()).userId);

      await signOut();

      if (!apiSignUpResult) {
        return AuthSignUpResult.error;
      }

      return await login(authCredentials) == LoginResult.success
          ? AuthSignUpResult.success
          : AuthSignUpResult.error;
    }
  }

  Future<KakaoUser?> kakaoLogin() async {
    try {
      await isKakaoTalkInstalled()
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();
      return KakaoUser(await UserApi.instance.me());
    } catch (e) {
      safePrint("debug! $e");
      return null;
    }
  }

  Future<void> kakaoUnlink() async {
    try {
      UserApi.instance.unlink();
    } catch (_) {}
  }

  bool _isUser(SignUpForm form) {
    return form.signUpTypeFirst == SignUpType.user;
  }

  bool _isCompany(SignUpForm form) {
    return form.signUpTypeFirst == SignUpType.compOrPlan &&
        form.signUpTypeSecond == SignUpType.company;
  }

  bool _isPlanner(SignUpForm form) {
    return form.signUpTypeFirst == SignUpType.compOrPlan &&
        form.signUpTypeSecond == SignUpType.planner;
  }

  Future<bool> _apiSignUp(SignUpForm form, String ampUid) async {
    if (_isUser(form)) {
      return _apiSignUpUser(form, ampUid);
    } else if (_isCompany(form)) {
      return _apiSignUpComp(form, ampUid);
    } else if (_isPlanner(form)) {
      return _apiSignUpPlanner(form, ampUid);
    } else {
      return false;
    }
  }

  Future<bool> _apiSignUpUser(SignUpForm form, String ampUid) async {
    Fluttertoast.showToast(msg: "coming soon!");
    return false;
  }

  Future<bool> _apiSignUpComp(SignUpForm form, String ampUid) async {
    final socialType = socialTypeToValue(form.socialSignUpType);
    final compType = idxTagToValue(form.compSignUpType);

    try {
      await _apiSign.signUpComp(
        PostCompSignUpRequest(
          ampUid: ampUid,
          socialType: socialType,
          comRegNum: form.compInfoForm.compNum!,
          compType: compType!,
          corpName: form.compInfoForm.corpName!,
          ceoName: form.compInfoForm.ceoName!,
          nickname: form.compInfoForm.nickname!,
          email: form.email!,
          address: form.compInfoForm.addressInfo!.roadAddress,
          addressDetails: form.compInfoForm.addrressDetails!,
          addrX: form.compInfoForm.addressInfo!.x,
          addrY: form.compInfoForm.addressInfo!.y,
          notiEvent: form.isAgreedEventNoti,
        ),
      );

      return true;
    } catch (e) {
      safePrint("exception: $e");
      return false;
    }
  }

  Future<bool> _apiSignUpPlanner(SignUpForm form, String ampUid) async {
    final socialType = socialTypeToValue(form.socialSignUpType);

    try {
      await _apiSign.signUpPlan(PostPlanSignUpRequest(
          ampUid: ampUid,
          socialType: socialType,
          teamName: form.planInfoForm.takeinCompName,
          phone: form.planInfoForm.phone,
          name: form.planInfoForm.name,
          nickname: form.planInfoForm.name,
          email: form.email!,
          birth: form.planInfoForm.birthDay!,
          notiEvent: form.isAgreedEventNoti));

      return true;
    } catch (e) {
      safePrint("exception: $e");
      return false;
    }
  }
}
