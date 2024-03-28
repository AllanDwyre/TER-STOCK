import 'package:flutter/material.dart';
import 'package:hive_stock/Product/models/product.dart';

import '../../App/constants/padding.dart';

class ProductBody extends StatelessWidget {
  final Product product;

  const ProductBody(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    // Hauteur et largeur totales
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          Container(
            width: size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: textTheme.displayMedium
                        ?.copyWith(color: colorTheme.onBackground),
                  ),
                  Text(
                    "Class ${product.class_ ?? "null"} | Sku : ${product.sku}",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
              child: Text(
                "Special handling",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(color: Colors.black),
              ),
            ),
          ),
          Container(
            // CONTAINER "TO FILL"
            height: 100,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.orangeAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text("to fill"),
            ),
          ),
          Container(
              // TABS A IMPLEMENTER ICI
              ),
        ],
      ),
    );
  }
}
