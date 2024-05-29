import 'package:formz/formz.dart';

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.isEmpty) return NameValidationError.empty;
    return null;
  }
}

enum CategoryValidationError { empty }

class Category extends FormzInput<String, CategoryValidationError> {
  const Category.pure() : super.pure('');
  const Category.dirty([super.value = '']) : super.dirty();

  @override
  CategoryValidationError? validator(String value) {
    if (value.isEmpty) return CategoryValidationError.empty;
    return null;
  }
}

enum DimensionValidationError { empty }

class Dimension extends FormzInput<String, DimensionValidationError> {
  const Dimension.pure() : super.pure('');
  const Dimension.dirty([super.value = '']) : super.dirty();

  @override
  DimensionValidationError? validator(String value) {
    if (value.isEmpty) return DimensionValidationError.empty;
    return null;
  }
}

enum WeightValidationError { empty }

class Weight extends FormzInput<String, WeightValidationError> {
  const Weight.pure() : super.pure('');
  const Weight.dirty([super.value = '']) : super.dirty();

  @override
  WeightValidationError? validator(String value) {
    if (value.isEmpty) return WeightValidationError.empty;
    return null;
  }
}

enum PriceValidationError { empty }

class Price extends FormzInput<String, PriceValidationError> {
  const Price.pure() : super.pure('');
  const Price.dirty([super.value = '']) : super.dirty();

  @override
  PriceValidationError? validator(String value) {
    if (value.isEmpty) return PriceValidationError.empty;
    return null;
  }
}