import 'package:hive_stock/App/constants/validation.dart';

class Authentification {
  Authentification({this.firstname, this.lastname});

  late String? firstname, lastname, phone, email, birthday;
  String? get fullname => '$firstname $lastname';

  bool nameValidation(String? value) => nameValidatorRegExp.hasMatch(value!);

  bool emailValidation(String? value) => emailValidatorRegExp.hasMatch(value!);

  bool phoneValidation(String? value) {
    return true;
  }

  // Only for naming 😂
  bool birthdayValidation() {
    return true;
  }

  String birthdayFormat(String? value) {
    return "";
  }
}
