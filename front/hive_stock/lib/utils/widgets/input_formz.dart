import 'package:formz/formz.dart';

// Define input validation errors
enum InputError { empty }

// Extend FormzInput and provide the input type and error type.
class Input extends FormzInput<String, InputError> {
  // Call super.pure to represent an unmodified form input.
  const Input.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Input.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  InputError? validator(String value) {
    return value.isEmpty ? InputError.empty : null;
  }
}