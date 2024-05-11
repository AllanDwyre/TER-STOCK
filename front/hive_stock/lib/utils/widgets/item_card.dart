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
          tag: productInventory.product.name,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8), // Image border
            child: Image.asset(CustomIcons.productImageTest),
          ),
        ),
        title: Text(
          productInventory.product.name,
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
          '${productInventory.product.unitPrice.ceil()}€/unit',
          style: textTheme.bodyLarge?.copyWith(color: colorTheme.secondary),
        ),
        onTap: onTap,
        onLongPress: () => {}, // too directly add new order, or edit
      ),
    );
  }
}

// class ItemCard extends StatelessWidget {
//   const ItemCard({super.key, required this.productInventory, this.press});

//   final ProductInventory productInventory;
//   final VoidCallback? press;

//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     ColorScheme colorTheme = Theme.of(context).colorScheme;

//     return GestureDetector(
//       onTap: press,
//       child: Container(
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 234, 239, 241),
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: ListTile(
//                   leading: Hero(
//                     tag: productInventory.product.name,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8), // Image border
//                       child: Image.asset(CustomIcons.productImageTest),
//                     ),
//                   ),
//                   title: Text(productInventory.product.name,
//                       style: textTheme.titleLarge
//                           ?.copyWith(color: colorTheme.secondary)),
//                   subtitle: productInventory.quantity == 0
//                       ? Text("Out of stock",
//                           style: textTheme.bodySmall
//                               ?.copyWith(color: lightColorScheme.outline))
//                       : Row(
//                           children: [
//                             Padding(
//                               padding:
//                                   const EdgeInsets.only(right: kDefaultPadding),
//                               child: Text("In-stock",
//                                   style: textTheme.bodySmall?.copyWith(
//                                       color: lightCustomColors.sourceSuccess)),
//                             ),
//                             Text("${productInventory.quantity} in stock",
//                                 style: textTheme.bodySmall),
//                           ],
//                         ),
//                   trailing: Text("${productInventory.product.unitPrice}€/unit",
//                       style: textTheme.bodyLarge
//                           ?.copyWith(color: colorTheme.secondary)),
//                 ),
//               ),
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.all(kDefaultPadding),
//             //   child: Column(
//             //     children: [
//             //       Align(
//             //         alignment: Alignment.centerLeft,
//             //         child: Text("Additionnal Information",
//             //             style: textTheme.bodyLarge
//             //                 ?.copyWith(color: colorTheme.secondary)),
//             //       ),
//             //       productInventory.specialHandling == null
//             //           ? Align(
//             //               alignment: Alignment.centerLeft,
//             //               child: Text("Non renseigné",
//             //                   style: textTheme.bodyMedium
//             //                       ?.copyWith(color: colorTheme.secondary)),
//             //             )
//             //           : Row(
//             //               children: <Widget>[
//             //                 Text(
//             //                     "${productInventory.specialHandling!.capitalize()} : ",
//             //                     style: textTheme.bodyMedium
//             //                         ?.copyWith(color: colorTheme.secondary)),
//             //                 Text("infos",
//             //                     style: textTheme.bodyMedium
//             //                         ?.copyWith(color: colorTheme.secondary)),
//             //               ],
//             //             ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
