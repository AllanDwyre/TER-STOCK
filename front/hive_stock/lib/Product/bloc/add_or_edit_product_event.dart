part of 'add_or_edit_product_bloc.dart';

sealed class AddOrEditProductEvent {}

class OnAddProduct extends AddOrEditProductEvent {}

class OnEditProduct extends AddOrEditProductEvent {}

class OnInformationChangeProduct extends AddOrEditProductEvent {}
