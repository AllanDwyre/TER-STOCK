part of 'product_bloc.dart';

final class ProductState extends Equatable {
  const ProductState({this.productdetails});

  final ProductInventory? productdetails;

  ProductState copyWith({ProductInventory? productdetails}) {
    return ProductState(
      productdetails: productdetails ?? this.productdetails,
    );
  }

  @override
  List<Object?> get props => [productdetails];
}
