import 'package:formz/formz.dart';
import 'package:hive_stock/utils/constants/constants.dart';

enum PhoneValidationError { empty, invalid }

class Phone extends FormzInput<String, PhoneValidationError> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  PhoneValidationError? validator(String value) {
    if (value.isEmpty) return PhoneValidationError.empty;
    if (phoneValidatorRegExp.hasMatch(value)) {
      return PhoneValidationError.invalid;
    }
    return null;
  }
}
