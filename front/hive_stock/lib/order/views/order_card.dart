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
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 234, 239, 241),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Order id : ${order.id ?? '-'}"),
                const SizedBox(width: 5),
                Text("${order.commande?.statusString}"),
                const Spacer(),
                Text("${order.commande?.prixTotal ?? '-'}€"),
              ],
            ),
            Text("${order.details?.first.nameProduct}"),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
