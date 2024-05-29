import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, required this.orderId});
  final int orderId;

  static Route route({required int id}) => MaterialPageRoute(
      builder: (context) => OrderPage(
            orderId: id,
          ));

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
