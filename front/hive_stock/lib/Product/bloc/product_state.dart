part of 'product_bloc.dart';

final class ProductState extends Equatable {
  const ProductState({this.product, this.barGroups});

  final Product? product;
  final List<BarChartGroupData>? barGroups;

  ProductState copyWith(
      {Product? product, List<BarChartGroupData>? barGroups}) {
    return ProductState(
      product: product ?? this.product,
      barGroups: barGroups ?? this.barGroups,
    );
  }

  @override
  List<Object?> get props => [product];
}
