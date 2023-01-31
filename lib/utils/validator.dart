class Validator {
  static final alpha = RegExp(r'[a-zA-Z]');
  static final numeric = RegExp(r'[0-9]');
  static final special = RegExp(r'[~!@#$%^&*()_+`{}|<>?;:./,=\-]');
  static final length = RegExp(r'.{8,}');

  static bool emailValidation(String email) {
    return email.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email);
  }

  static int getPassSecurityLevel(String pw) {
    int securityLevel = 0;

    if (alpha.hasMatch(pw)) {
      securityLevel++;
    }
    if (numeric.hasMatch(pw)) {
      securityLevel++;
    }
    if (special.hasMatch(pw)) {
      securityLevel++;
    }
    if (length.hasMatch(pw)) {
      securityLevel++;
    }

    return securityLevel;
  }
}
