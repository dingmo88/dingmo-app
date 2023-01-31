import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dingmo/amplifyconfiguration.dart';

enum AmpResState { yes, no, error, limited }

class AwsAmplify {
  Future<bool> configure() async {
    await Amplify.Auth.addPlugin(AmplifyAuthCognito());

    try {
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured Amplify 🎉');
      return true;
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          "Amplify was already configured. Looks like app restarted on android.");
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      return (await Amplify.Auth.fetchAuthSession()).isSignedIn;
    } catch (e) {
      safePrint("exception: $e");
      return false;
    }
  }

  Future<AuthUser> getCurrentUser() {
    return Amplify.Auth.getCurrentUser();
  }

  Future<void> deleteUser() {
    return Amplify.Auth.deleteUser();
  }

  Future<AmpResState> loginWithCredentials(AuthCredentials credentials) async {
    try {
      return (await Amplify.Auth.signIn(
                  username: credentials.email, password: credentials.password))
              .isSignedIn
          ? AmpResState.yes
          : AmpResState.no;
    } catch (e) {
      safePrint("exception: $e");
      return AmpResState.error;
    }
  }

  Future<AmpResState> signUpWithCredentials(AuthCredentials credentials) async {
    try {
      return (await Amplify.Auth.signUp(
                  username: credentials.email,
                  password: credentials.password,
                  options: CognitoSignUpOptions(userAttributes: {
                    CognitoUserAttributeKey.email: credentials.email
                  })))
              .isSignUpComplete
          ? AmpResState.yes
          : AmpResState.no;
    } catch (e) {
      safePrint("exception: $e");

      if (e is LimitExceededException) {
        return AmpResState.limited;
      } else if (e is UsernameExistsException) {
        try {
          await Amplify.Auth.resendSignUpCode(username: credentials.email);
          return AmpResState.yes;
        } catch (e) {
          return AmpResState.error;
        }
      } else {
        return AmpResState.error;
      }
    }
  }

  Future<AmpResState> verifyCode(
      AuthCredentials credentials, String verificationCode) async {
    try {
      return (await Amplify.Auth.confirmSignUp(
                  username: credentials.email,
                  confirmationCode: verificationCode))
              .isSignUpComplete
          ? AmpResState.yes
          : AmpResState.no;
    } catch (e) {
      safePrint("exception: $e");
      return e is CodeMismatchException ? AmpResState.no : AmpResState.error;
    }
  }

  Future<AmpResState> sendRecoveryCode(String email) async {
    try {
      await Amplify.Auth.resetPassword(username: email);
      return AmpResState.yes;
    } catch (e) {
      safePrint("exception: $e");
      if (e is UserNotFoundException) {
        return AmpResState.no;
      } else if (e is LimitExceededException) {
        return AmpResState.limited;
      } else {
        return AmpResState.error;
      }
    }
  }

  Future<AmpResState> confirmResetPassword(
      AuthCredentials credentials, String verifyCode) async {
    try {
      await Amplify.Auth.confirmResetPassword(
          username: credentials.email,
          newPassword: credentials.password,
          confirmationCode: verifyCode);
      return AmpResState.yes;
    } catch (e) {
      safePrint("exception: $e");

      if (e is LimitExceededException) {
        return AmpResState.limited;
      } else {
        return e is CodeMismatchException ? AmpResState.no : AmpResState.error;
      }
    }
  }

  Future<AmpResState> updatePassword(
      String oldPassword, String newPasasword) async {
    try {
      await Amplify.Auth.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPasasword,
      );
      return AmpResState.yes;
    } catch (e) {
      safePrint("exception: $e");

      if (e is NotAuthorizedException) {
        return AmpResState.no;
      } else if (e is LimitExceededException) {
        return AmpResState.limited;
      }

      return AmpResState.error;
    }
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}

class AuthCredentials {
  final String email;
  final String password;

  AuthCredentials({required this.email, required this.password});
}
