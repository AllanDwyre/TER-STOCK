part of 'product_bloc.dart';

enum ProductStatus { initial, success, failure }

final class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.products = const <ProductInventory>[],
    this.hasReachedMax = false,
  });

  final ProductStatus status;
  final List<ProductInventory> products;
  final bool hasReachedMax;

  ProductState copyWith({
    ProductStatus? status,
    List<ProductInventory>? products,
    bool? hasReachedMax,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''productstate { status: $status, hasReachedMax: $hasReachedMax, products: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}
