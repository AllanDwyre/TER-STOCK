part of 'scanner_bloc.dart';

enum FetchOrderStatus { initial, success, done, inProgress, orderError }

class ScannerState extends Equatable {
  final FetchOrderStatus status;
  final String? message;
  final ScanResponse? response;

  const ScannerState({
    this.message,
    this.status = FetchOrderStatus.initial,
    this.response,
  });

  ScannerState copyWith({
    FetchOrderStatus? status,
    String? message,
    ScanResponse? response,
  }) {
    return ScannerState(
      status: status ?? this.status,
      message: message ?? this.message,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
