import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    // TODO :  add regex validation to password
    // if (!passwordValidatorRegExp.hasMatch(value)) {
    //   return PasswordValidationError.invalid;
    // }
    return null;
  }
}
