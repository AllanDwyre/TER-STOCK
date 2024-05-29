import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_stock/order/models/order.dart';
import 'package:hive_stock/order/repository/order_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:stream_transform/stream_transform.dart';

part 'orders_event.dart';
part 'orders_state.dart';

const _orderLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

/// Optimisation qui permet d'ignorer les nouveau events tant que l'éxecution de l'évent actuelle n'est pas finis afin d'éviter de spammer inutilement notre Backend.
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository _orderRepository;

  OrdersBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(const OrdersState()) {
    on<OrdersFetched>(_onOrdersFetched);
    on<OrdersTypeChange>(_onTypeChanged);
  }

  Future<void> _onOrdersFetched(
      OrdersFetched event, Emitter<OrdersState> emit) async {
    await _fecthOrderLogic(emit);
  }

  FutureOr<void> _onTypeChanged(
      OrdersTypeChange event, Emitter<OrdersState> emit) async {
    emit(
      state.copyWith(
        type: event.type,
        hasReachedMax: false,
        orders: List.empty(),
      ),
    );
    await _fecthOrderLogic(emit);
  }

  Future<void> _fecthOrderLogic(Emitter<OrdersState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == OrdersStatus.initial) {
        final orders = await _fetchOrders();
        return emit(state.copyWith(
          status: OrdersStatus.success,
          orders: orders,
          hasReachedMax: false,
        ));
      }
      final orders = await _fetchOrders(state.orders.length);
      emit(orders.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: OrdersStatus.success,
              orders: List.of(state.orders)..addAll(orders),
              hasReachedMax: false,
            ));
    } on Exception catch (e) {
      emit(state.copyWith(status: OrdersStatus.failure));
      logger.e('Erreur de récupération de list orders\n=> $e',
          error: 'Order Bloc');
    }
  }

  Future<List<Order>> _fetchOrders([int startIndex = 0]) async {
    try {
      final List<Order> orders = await _orderRepository.fetchOrders(
          start: startIndex, limit: _orderLimit, type: state.type);
      return orders;
    } catch (e) {
      logger.w("error fetching posts: $e", error: 'Orders Bloc');
      return List<Order>.empty();
    }
  }
}
