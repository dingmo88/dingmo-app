enum SocialType { kakao, apple, email }

int socialTypeToValue(SocialType? socialSignUpType) {
  if (socialSignUpType == SocialType.kakao) {
    return 1;
  } else if (socialSignUpType == SocialType.apple) {
    return 2;
  } else if (socialSignUpType == SocialType.email) {
    return 3;
  } else {
    return 3;
  }
}

SocialType valueToSocialType(int value) {
  if (value == 1) {
    return SocialType.kakao;
  } else if (value == 2) {
    return SocialType.apple;
  } else {
    return SocialType.email;
  }
}
