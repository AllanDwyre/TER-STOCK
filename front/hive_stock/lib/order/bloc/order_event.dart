part of 'order_bloc.dart';

sealed class OrderEvent {}

final class OrderFetched extends OrderEvent {
  OrderFetched({required this.id});
  final int id;
}
