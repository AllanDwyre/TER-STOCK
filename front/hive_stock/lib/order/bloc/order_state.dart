part of 'order_bloc.dart';

final class OrderState extends Equatable {
  const OrderState({this.orderData});

  final Order? orderData;

  OrderState copyWith({Order? orderData}) {
    return OrderState(
      orderData: orderData ?? this.orderData,
    );
  }

  @override
  List<Object?> get props => [orderData];
}
