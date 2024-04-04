import 'package:formz/formz.dart';

enum UsernameValidationError { empty, invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([super.value = '']) : super.dirty();

  @override
  UsernameValidationError? validator(String value) {
    if (value.isEmpty) return UsernameValidationError.empty;
    // TODO: regex validation
    // if (!nameValidatorRegExp.hasMatch(value)) {
    //   return UsernameValidationError.invalid;
    // }
    return null;
  }
}
