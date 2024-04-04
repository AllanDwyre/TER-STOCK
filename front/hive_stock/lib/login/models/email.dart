import 'package:formz/formz.dart';
import 'package:hive_stock/utils/constants/constants.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (emailValidatorRegExp.hasMatch(value)) {
      return EmailValidationError.invalid;
    }
    return null;
  }
}
