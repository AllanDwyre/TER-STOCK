part of 'add_or_edit_product_bloc.dart';

sealed class AddOrEditProductEvent {}

class OnSumbitProduct extends AddOrEditProductEvent {}

class OnEditProductFetch extends AddOrEditProductEvent {
  final int id;

  OnEditProductFetch({required this.id});
}

class OnInformationChangeProduct extends AddOrEditProductEvent {
  final String? name;
  final String? category;
  final String? dimension;
  final String? weight;
  final String? price;

  OnInformationChangeProduct(
      {this.name, this.category, this.dimension, this.weight, this.price});
}
