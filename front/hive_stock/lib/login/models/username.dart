import 'package:formz/formz.dart';
import 'package:hive_stock/_global/constants/constants.dart';

enum UsernameValidationError { empty, invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    if (nameValidatorRegExp.hasMatch(value)) {
      return UsernameValidationError.invalid;
    }
    return null;
  }
}
