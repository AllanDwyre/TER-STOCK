import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/order/bloc/order_bloc.dart';
import 'package:hive_stock/order/repository/order_repository.dart';

import 'order_body.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, required this.orderId, this.isFromScan = false});
  final int orderId;
  final bool isFromScan;

  static Route route({required int id}) => MaterialPageRoute(
      builder: (context) => OrderPage(
            orderId: id,
          ));

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (isFromScan) {
        return _communWidget();
      }
      return Scaffold(
        appBar: AppBar(),
        body: _communWidget(),
      );
    });
  }

  RepositoryProvider<OrderRepository> _communWidget() {
    return RepositoryProvider(
      create: (context) => OrderRepository(),
      child: BlocProvider(
        create: (context) => OrderBloc(
            orderRepository: RepositoryProvider.of<OrderRepository>(context))
          ..add(OrderFetched(id: orderId)),
        child: OrderBody(
          isFromScan: isFromScan,
        ),
      ),
    );
  }
}
