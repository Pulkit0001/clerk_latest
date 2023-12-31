import 'package:email_validator/email_validator.dart';

extension TextFieldValidators on String {
  String? validateAsName() {
    replaceAll("-", "\-");
    replaceAll('\ '.substring(0, 1), "\\");

    return isNotEmpty
        ? contains(RegExp(r'[A-Za-z]')) &&
                !contains(RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%-]'))
            ? null
            : "Enter a valid name (Only alphabets and numbers are allowed)"
        : "Please provide name";
  }

  String? validateAsAge() {
    replaceAll("-", "\-");
    replaceAll('\ '.substring(0, 1), "\\");

    return isNotEmpty ? null : "Enter a valid age";
  }

  String? validateAsAmount() {
    replaceAll("-", "\-");
    replaceAll('\ '.substring(0, 1), "\\");

    return isNotEmpty && double.tryParse(this) != null
        ? null
        : "Enter a valid amount";
  }

  String? validateAsPhone() {
    replaceAll("-", "\-");
    replaceAll('\ '.substring(0, 1), "\\");

    return isNotEmpty
        ? length == 10
            ? null
            : "Enter a valid Phone Number"
        : "Please provide Phone Number";
  }

  String? validateAsOptionalPhone() {
    replaceAll("-", "\-");
    replaceAll('\ '.substring(0, 1), "\\");

    return isNotEmpty
        ? length == 10
            ? null
            : "Enter a valid Phone Number"
        : null;
  }

  String? validateAsEmail() {
    return EmailValidator.validate(this) ? null : "Enter a valid email";
  }
}
