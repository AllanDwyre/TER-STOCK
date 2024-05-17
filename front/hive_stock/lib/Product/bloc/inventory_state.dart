part of 'inventory_bloc.dart';

enum InventoryStatus { initial, success, failure }

final class InventoryState extends Equatable {
  const InventoryState({
    this.status = InventoryStatus.initial,
    this.products = const <ProductInventory>[],
    this.hasReachedMax = false,
  });

  final InventoryStatus status;
  final List<ProductInventory> products;
  final bool hasReachedMax;

  InventoryState copyWith({
    InventoryStatus? status,
    List<ProductInventory>? products,
    bool? hasReachedMax,
  }) {
    return InventoryState(
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

  @override
  bool? get stringify => throw UnimplementedError();
}
