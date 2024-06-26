import 'package:formz/formz.dart';
import 'package:hive_stock/utils/constants/constants.dart';

enum BirthdayValidationError { empty, invalid }

class Birthday extends FormzInput<String, BirthdayValidationError> {
  const Birthday.pure() : super.pure('');
  const Birthday.dirty([super.value = '']) : super.dirty();

  @override
  BirthdayValidationError? validator(String value) {
    if (value.isEmpty) return BirthdayValidationError.empty;
    if (birthdayValidatorRegExp.hasMatch(value)) {
      return BirthdayValidationError.invalid;
    }
    return null;
  }
}
