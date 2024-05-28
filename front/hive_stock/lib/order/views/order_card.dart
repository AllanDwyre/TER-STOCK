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
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(15),
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
                _Status(order: order),
                Spacer(),
                Text("${order.commande?.prixTotal ?? '-'}€"),
              ],
            ),
            Text("${order.details?.first.nameProduct ?? '-'}"),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class _Status extends StatelessWidget {
  const _Status({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Text("${order.commande?.status ?? '-'}");
  }
}
