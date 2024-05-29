import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_stock/order/models/order.dart';
import 'package:hive_stock/order/repository/order_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository _orderRepository;

  OrderBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(const OrderState()) {
    on<OrderFetched>(_onOrderFectch);
  }

  FutureOr<void> _onOrderFectch(
      OrderFetched event, Emitter<OrderState> emit) async {
    final order = await _tryGetOrder(event.id);

    emit(
      state.copyWith(orderData: order),
    );
  }

  Future<Order?> _tryGetOrder(int id) async {
    try {
      logger.t('Order Fetching ...');

      return await _orderRepository.getOrder(id);
    } catch (e) {
      logger.e('$e', error: 'Order Fetching Stack');
      //TODO :
      throw Exception('error fetching order: $e');
    }
  }
}
