import 'package:formz/formz.dart';
import 'package:hive_stock/utils/app/configuration.dart';
import 'package:hive_stock/utils/constants/validation.dart';

enum PasswordValidationError { empty, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    // if the password is in good format and its on production only (c'est pour que en debug mode on a pas à écrire de long mdp complexe)
    if (!passwordValidatorRegExp.hasMatch(value) &&
        !ApiConfiguration.isDebugMode) {
      return PasswordValidationError.invalid;
    }
    return null;
  }
}
