import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive_stock/order/models/order.dart';
import 'package:hive_stock/utils/constants/colors.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, this.onTap, required this.order});
  final Function()? onTap;
  final Order order;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    // Size size = MediaQuery.of(context).size;
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
                Text(
                  "${order.commande?.statusString}",
                  style: textTheme.labelSmall?.copyWith(
                      color: getColorStatus(context, order.commande?.status)),
                ),
                const Spacer(),
                Text("${order.commande?.prixTotal ?? '-'}€"),
              ],
            ),
            _buildProductName(textTheme, context),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _buildProductName(TextTheme textTheme, BuildContext context) {
    if (order.details == null) {
      return const Text("");
    }
    var maxP = order.details
        ?.getRange(0, min(order.details!.length, 5))
        .map((detail) => detail.nameProduct)
        .toList();

    return Text(
      overflow: TextOverflow.fade,
      maxP!.join(" | "),
      style: textTheme.titleSmall
          ?.copyWith(color: Theme.of(context).colorScheme.secondary),
    );
  }

  Color? getColorStatus(BuildContext context, int? status) {
    switch (status) {
      case 0:
        return Theme.of(context).colorScheme.outline;
      case 1:
        return lightCustomColors.sourceWarning;
      case 2:
        return lightCustomColors.sourceSuccess;
      default:
        return Theme.of(context).colorScheme.outline;
    }
  }
}
