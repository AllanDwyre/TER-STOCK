import 'package:flutter/material.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/utils/constants/constants.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'dart:convert';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, this.onTap});
  final Product product;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    Image? imageProduct;
    try {
      if (product.img != null) {
        String? substr = product.img!.substring(1, product.img!.length - 1);
        imageProduct = Image.memory(
            base64Decode(product.img![0] == '"' ? substr : product.img![0]));
      }
    } catch (e) {
      logger.t(e);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        tileColor: const Color.fromARGB(255, 234, 239, 241),
        leading: Hero(
          tag: product.name ?? "-",
          child: Container(
            constraints: const BoxConstraints(minWidth: 60, maxWidth: 60),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Image border
              child: imageProduct ?? Image.asset(CustomIcons.productImageTest),
            ),
          ),
        ),
        title: Text(
          product.name ?? "-",
          style: textTheme.titleMedium?.copyWith(color: colorTheme.secondary),
        ),
        subtitle: Row(
          children: [
            Text(
              (product.quantity ?? 0) > 0 ? 'In-stock' : 'Out of stock',
              style: textTheme.bodySmall?.copyWith(
                color: (product.quantity ?? 0) > 0
                    ? lightCustomColors.sourceSuccess
                    : colorTheme.secondary,
              ),
            ),
            const SizedBox(width: 10),
            Visibility(
              visible: (product.quantity ?? 0) > 0,
              child: Text(
                '${product.quantity} in stock',
                style:
                    textTheme.bodySmall?.copyWith(color: colorTheme.secondary),
              ),
            ),
          ],
        ),
        trailing: Text(
          '${product.unitPrice}€/unit',
          style: textTheme.bodyLarge?.copyWith(color: colorTheme.secondary),
        ),
        onTap: onTap,
        onLongPress: () => {}, // too directly add new order, or edit
      ),
    );
  }
}
