import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/_global/constants/constants.dart';

enum OtpValidationError { empty, lenght, invalid }

class Otp extends FormzInput<String, OtpValidationError> {
  const Otp.pure() : super.pure('');
  const Otp.dirty([super.value = '']) : super.dirty();

  @override
  OtpValidationError? validator(String value) {
    debugPrint(value);
    if (value.isEmpty) return OtpValidationError.empty;
    if (!isnumericRegex.hasMatch(value)) {
      return OtpValidationError.invalid;
    } else if (value.length != 6) {
      return OtpValidationError.lenght;
    }

    return null;
  }
}
