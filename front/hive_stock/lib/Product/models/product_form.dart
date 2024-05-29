import 'package:formz/formz.dart';

enum ProductIdValidationError { empty }

class ProductId extends FormzInput<String, ProductIdValidationError> {
  const ProductId.pure() : super.pure('');
  const ProductId.dirty([super.value = '']) : super.dirty();

  @override
  ProductIdValidationError? validator(String value) {
    if (value.isEmpty) return ProductIdValidationError.empty;
    return null;
  }
}

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

enum DescriptionValidationError { empty }

class Description extends FormzInput<String, DescriptionValidationError> {
  const Description.pure() : super.pure('');
  const Description.dirty([super.value = '']) : super.dirty();

  @override
  DescriptionValidationError? validator(String value) {
    if (value.isEmpty) return DescriptionValidationError.empty;
    return null;
  }
}

enum UnitPriceValidationError { empty }

class UnitPrice extends FormzInput<String, UnitPriceValidationError> {
  const UnitPrice.pure() : super.pure('');
  const UnitPrice.dirty([super.value = '']) : super.dirty();

  @override
  UnitPriceValidationError? validator(String value) {
    if (value.isEmpty) return UnitPriceValidationError.empty;
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

enum WarehouseValidationError { empty }

class Warehouse extends FormzInput<String, WarehouseValidationError> {
  const Warehouse.pure() : super.pure('');
  const Warehouse.dirty([super.value = '']) : super.dirty();

  @override
  WarehouseValidationError? validator(String value) {
    if (value.isEmpty) return WarehouseValidationError.empty;
    return null;
  }
}

enum BarcodeValidationError { empty }

class Barcode extends FormzInput<String, BarcodeValidationError> {
  const Barcode.pure() : super.pure('');
  const Barcode.dirty([super.value = '']) : super.dirty();

  @override
  BarcodeValidationError? validator(String value) {
    if (value.isEmpty) return BarcodeValidationError.empty;
    return null;
  }
}

enum CategoryIdValidationError { empty }

class CategoryId extends FormzInput<String, CategoryIdValidationError> {
  const CategoryId.pure() : super.pure('');
  const CategoryId.dirty([super.value = '']) : super.dirty();

  @override
  CategoryIdValidationError? validator(String value) {
    if (value.isEmpty) return CategoryIdValidationError.empty;
    return null;
  }
}

enum LocationIdValidationError { empty }

class LocationId extends FormzInput<String, LocationIdValidationError> {
  const LocationId.pure() : super.pure('');
  const LocationId.dirty([super.value = '']) : super.dirty();

  @override
  LocationIdValidationError? validator(String value) {
    if (value.isEmpty) return LocationIdValidationError.empty;
    return null;
  }
}

enum SupplierIdValidationError { empty }

class SupplierId extends FormzInput<String, SupplierIdValidationError> {
  const SupplierId.pure() : super.pure('');
  const SupplierId.dirty([super.value = '']) : super.dirty();

  @override
  SupplierIdValidationError? validator(String value) {
    if (value.isEmpty) return SupplierIdValidationError.empty;
    return null;
  }
}

enum ImgValidationError { empty }

class Img extends FormzInput<String, ImgValidationError> {
  const Img.pure() : super.pure('');
  const Img.dirty([super.value = '']) : super.dirty();

  @override
  ImgValidationError? validator(String value) {
    if (value.isEmpty) return ImgValidationError.empty;
    return null;
  }
}