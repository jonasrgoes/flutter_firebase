class Validator {
  static bool validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return false;
    }
    return true;
  }

  static bool validateFinanceValue(String number) {
    return double.tryParse(number) != null;
  }

  static bool validatePassword(String value) {
    if (value.length < 6) {
      return false;
    }
    return true;
  }
}
