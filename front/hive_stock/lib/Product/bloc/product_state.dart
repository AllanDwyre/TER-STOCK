part of 'product_bloc.dart';

final class ProductState extends Equatable {
  const ProductState({this.product});

  final Product? product;

  ProductState copyWith({Product? product}) {
    return ProductState(
      product: product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [product];
}
