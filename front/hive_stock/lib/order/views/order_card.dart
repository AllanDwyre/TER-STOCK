import 'package:flutter/material.dart';
import 'package:hive_stock/order/models/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, this.onTap, required this.order});
  final Function()? onTap;
  final Order order;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 239, 241),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
