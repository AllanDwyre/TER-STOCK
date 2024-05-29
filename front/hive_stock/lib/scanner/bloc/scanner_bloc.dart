import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_stock/order/models/order.dart';
import 'package:hive_stock/order/repository/order_repository.dart';
import 'package:hive_stock/scanner/models/scan_response.dart';
import 'package:hive_stock/utils/methods/logger.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  final OrderRepository _orderRepository;
  ScannerBloc({required OrderRepository orderRepository})
      : _orderRepository = orderRepository,
        super(const ScannerState()) {
    on<ScannerFectchIncommingEvent>(_onFecthIncomming);
  }

  FutureOr<void> _onFecthIncomming(
      ScannerFectchIncommingEvent event, Emitter<ScannerState> emit) async {
    Order? order = await _tryGetOrder(event.id);
    if (order == null) {
      emit(
        state.copyWith(
          status: FetchOrderStatus.orderError,
          message: "The current order wasn't ask from us.\nReturn the order.",
        ),
      );
    }
    // state.response.
  }

  Future<Order?> _tryGetOrder(int id) async {
    try {
      return await _orderRepository.getOrder(id);
    } catch (e) {
      logger.w(e);
      return null;
    }
  }
}
