part of 'orders_bloc.dart';

enum OrdersStatus { initial, success, failure }

final class OrdersState extends Equatable {
  const OrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const <Order>[],
    this.hasReachedMax = false,
    this.type = 0,
    this.stats,
  });

  final OrdersStatus status;
  final List<Order> orders;
  final bool hasReachedMax;
  final int type;
  final OrdersStats? stats;

  OrdersState copyWith({
    OrdersStatus? status,
    List<Order>? orders,
    bool? hasReachedMax,
    int? type,
    OrdersStats? stats,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      type: type ?? this.type,
      stats: stats ?? this.stats,
    );
  }

  @override
  String toString() {
    return '''orderstate { status: $status, hasReachedMax: $hasReachedMax, orders: ${orders.length}, type: $type }''';
  }

  @override
  List<Object> get props => [status, type, orders, hasReachedMax];

  @override
  bool? get stringify => throw UnimplementedError();
}
