part of 'add_or_edit_product_bloc.dart';

sealed class AddOrEditProductEvent {}

class OnSumbitProduct extends AddOrEditProductEvent {}

class OnEditProductFetch extends AddOrEditProductEvent {
  final int id;

  OnEditProductFetch({required this.id});
}

class OnAddImg extends AddOrEditProductEvent {
  final String? img;
  final String? pathImg;
  final String? titleImg;

  OnAddImg(
      {this.img, this.pathImg, this.titleImg});
}

class OnInformationChangeProduct extends AddOrEditProductEvent {
  final String? name;
  final String? category;
  final String? dimension;
  final String? weight;
  final String? price;
  final String? img;

  OnInformationChangeProduct(
      {this.name, this.category, this.dimension, this.weight, this.price, this.img});
}
