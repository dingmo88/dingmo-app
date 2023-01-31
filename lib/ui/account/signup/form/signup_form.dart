import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/social_type.dart';
import 'package:dingmo/ui/account/signup/form/planner_form.dart';
import 'package:dingmo/ui/account/signup/form/user_form.dart';
import 'package:dingmo/constants/signup_type_enum.dart';

import 'company_form.dart';
import 'profile_form.dart';

class SignUpForm {
  static final SignUpForm _instance = SignUpForm._internal();

  String? startRouteName;

  bool isAgreedEventNoti = false;

  String? email;
  String? password;

  SignUpType? signUpTypeFirst;
  SignUpType? signUpTypeSecond;
  IdxTag? compSignUpType;
  SocialType? socialSignUpType;

  CompanyInfoForm compInfoForm = CompanyInfoForm();
  PlannerInfoForm planInfoForm = PlannerInfoForm();
  UserInfoForm userInfoForm = UserInfoForm();

  PlanProfileForm planProfileForm = PlanProfileForm();
  CompProfileForm compProfileForm = CompProfileForm();

  SignUpForm._internal();

  factory SignUpForm.instance() {
    return _instance;
  }

  void clear() {
    startRouteName = null;

    email = null;
    password = null;

    socialSignUpType = null;
    signUpTypeFirst = null;
    signUpTypeSecond = null;
    compSignUpType = null;

    compInfoForm = CompanyInfoForm();
    planInfoForm = PlannerInfoForm();
    userInfoForm = UserInfoForm();

    planProfileForm = PlanProfileForm();
    compProfileForm = CompProfileForm();

    isAgreedEventNoti = false;
  }
}
