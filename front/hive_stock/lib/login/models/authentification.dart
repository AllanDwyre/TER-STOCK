import 'dart:math';

import 'package:hive_stock/utils/constants/constants.dart';

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Obselete !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
class Authentification {
  Authentification({this.firstname, this.lastname});

  late String? firstname, lastname, phone, email, birthday;
  String? get fullname => '$firstname $lastname';

  static String? nameValidation(String? value) {
    if (value == null) return "Veuillez saisir votre nom";
    return nameValidatorRegExp.hasMatch(value)
        ? null
        : "Votre nom n'est pas comforme.";
  }

  static String? emailValidation(String? value) {
    if (value == null) return "Veuillez saisir votre email";
    return emailValidatorRegExp.hasMatch(value)
        ? null
        : "Votre email n'est pas comforme.";
  }

  static String? phoneValidation(String? value) {
    if (value == null) return "Veuillez saisir votre numéro de téléphone";
    return phoneValidatorRegExp.hasMatch(value)
        ? null
        : "Votre numéro de téléphone n'est pas comforme.";
  }

  static String? birthdayValidation(String? value) {
    if (value == null) return "Veuillez saisir votre date de naissance";
    return birthdayValidatorRegExp.hasMatch(value)
        ? null
        : "Votre date de naissance n'est pas comforme.";
  }

  static String birthdayFormat(String value) {
    value = value.trim();

    if (value.isEmpty) {
      return "";
    }
    String day = value.substring(0, min(2, value.length));
    String month = "";
    String year = "";

    if (value.length > 2) {
      month = value.substring(2, min(4, value.length));
    }
    if (value.length > 4) {
      year = value.substring(4, min(8, value.length));
    }
    return "$day $month $year";
  }
}
