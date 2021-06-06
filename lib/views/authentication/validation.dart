abstract class PasswordValidator {
  static bool validate(String value) {
    String pattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%.*?&+.-_])[A-Za-z\d@$!%.*?&+._-]{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
