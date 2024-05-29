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
    on<ScannerFectchEvent>(_onFecth);
  }

  FutureOr<void> _onFecth(
      ScannerFectchEvent event, Emitter<ScannerState> emit) async {
    emit(state.copyWith(response: event.response));

    Order? order = await _tryGetOrder(event.response.id ?? -1);
    if (order == null) {
      emit(
        state.copyWith(
          status: FetchOrderStatus.orderError,
          message: "The current order wasn't ask from us.\nReturn the order.",
        ),
      );
    } else {
      _handleChecking(
        emit: emit,
        validData: order,
        data: event.response,
      );
    }
  }

  void _handleChecking(
      {required Emitter<ScannerState> emit,
      required Order validData,
      required ScanResponse data}) {
    if (data.isIncoming) {
      _handleCheckingIncoming(emit: emit, validData: validData, data: data);
    } else {
      _handleCheckingOutgoing(emit: emit, validData: validData, data: data);
    }
  }

  void _handleCheckingIncoming(
      {required Emitter<ScannerState> emit,
      required Order validData,
      required ScanResponse data}) {
    if (data.isIncoming != validData.isEntry) {
      emit(
        state.copyWith(
            message:
                "The current order need to be returned.\n(OrderType missmatched)",
            status: FetchOrderStatus.orderError),
      );
      return;
    }
    if (data.expectedLocation == validData.commande!.locationType) {
      emit(
        state.copyWith(
            status: FetchOrderStatus.orderError,
            message:
                "The current order doesn't arrived at the correct destination.\nPlease return it."),
      );
      return;
    }
    validData.details?.forEach((element) {
      bool isValid = data.details!.any((valid) =>
          valid.productName == element.nameProduct &&
          valid.quantity == element.quantity);
      if (!isValid) {
        emit(state.copyWith(
            message:
                "The incoming order doesn't have the required content, ${element.nameProduct} : ${element.quantity},\n Must renew the order...",
            status: FetchOrderStatus.orderError));
        return;
      }
    });
    if (validData.commande!.isArrived) {
      emit(state.copyWith(
          status: FetchOrderStatus.done,
          message: "The current order as already been process"));
      return;
    }
    emit(state.copyWith(status: FetchOrderStatus.success));
  }

  void _handleCheckingOutgoing(
      {required Emitter<ScannerState> emit,
      required Order validData,
      required ScanResponse data}) {
    if (data.isOutgoing != validData.isExit) {
      emit(
        state.copyWith(
            message:
                "The current order need to be returned.\n(OrderType missmatched)",
            status: FetchOrderStatus.orderError),
      );
      return;
    }
    if (data.expectedLocation == validData.commande!.locationType) {
      emit(
        state.copyWith(
            status: FetchOrderStatus.orderWarning,
            message:
                "Destination missmatched!.\nPlease return the correct the destination information on the order package."),
      );
      return;
    }
    validData.details?.forEach((element) {
      bool isValid = data.details!.any((valid) =>
          valid.productName == element.nameProduct &&
          valid.quantity == element.quantity);
      if (!isValid) {
        emit(state.copyWith(
            message:
                "The outgoing order doesn't have the required content, ${element.nameProduct}",
            status: FetchOrderStatus.orderWarning));
        return;
      }
    });
    if (validData.commande!.isArrived) {
      emit(state.copyWith(
          status: FetchOrderStatus.done,
          message: "The current order as already been process"));
      return;
    }
    emit(state.copyWith(status: FetchOrderStatus.success));
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
