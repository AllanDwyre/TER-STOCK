part of 'orders_bloc.dart';

enum OrdersStatus { initial, success, failure }

final class OrdersState extends Equatable {
  const OrdersState({
    this.status = OrdersStatus.initial,
    this.orders = const <Order>[],
    this.hasReachedMax = false,
    this.type = 0,
  });

  final OrdersStatus status;
  final List<Order> orders;
  final bool hasReachedMax;
  final int type;

  OrdersState copyWith({
    OrdersStatus? status,
    List<Order>? orders,
    bool? hasReachedMax,
    int? type,
  }) {
    return OrdersState(
      status: status ?? this.status,
      orders: orders ?? this.orders,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      type: type ?? this.type,
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
