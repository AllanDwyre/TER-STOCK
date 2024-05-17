part of 'product_bloc.dart';

sealed class ProductEvent {}

final class ProductFetched extends ProductEvent {
  ProductFetched({required this.id});
  final int id;
}
