abstract class PasswordValidator {
  static bool validate(String value) {
    String pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
