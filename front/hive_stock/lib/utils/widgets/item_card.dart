import 'package:flutter/material.dart';
import 'package:hive_stock/product/models/product_inventory.dart';
import 'package:hive_stock/utils/constants/constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productInventory, this.onTap});
  final ProductInventory productInventory;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        tileColor: const Color.fromARGB(255, 234, 239, 241),
        leading: Hero(
          tag: productInventory.product.name ?? "-",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8), // Image border
            child: Image.asset(CustomIcons.productImageTest),
          ),
        ),
        title: Text(
          productInventory.product.name ?? "-",
          style: textTheme.titleMedium?.copyWith(color: colorTheme.secondary),
        ),
        subtitle: Row(
          children: [
            Text(
              productInventory.quantity > 0 ? 'In-stock' : 'Out of stock',
              style: textTheme.bodySmall?.copyWith(
                color: productInventory.quantity > 0
                    ? lightCustomColors.sourceSuccess
                    : colorTheme.secondary,
              ),
            ),
            const SizedBox(width: 10),
            Visibility(
              visible: productInventory.quantity > 0,
              child: Text(
                '${productInventory.quantity} in stock',
                style:
                    textTheme.bodySmall?.copyWith(color: colorTheme.secondary),
              ),
            ),
          ],
        ),
        trailing: Text(
          '${productInventory.product.unitPrice}€/unit',
          style: textTheme.bodyLarge?.copyWith(color: colorTheme.secondary),
        ),
        onTap: onTap,
        onLongPress: () => {}, // too directly add new order, or edit
      ),
    );
  }
}
