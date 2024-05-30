part of 'orders_bloc.dart';

sealed class OrdersEvent {}

class OrdersFetched implements OrdersEvent {}

class OrdersStatsFetched implements OrdersEvent {}

class OrdersTypeChange implements OrdersEvent {
  int type;
  OrdersTypeChange({required this.type});
}
