import 'package:flutter/material.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/utils/constants/colors.dart';
import 'package:hive_stock/utils/constants/padding.dart';
import 'package:hive_stock/utils/methods/string_extension.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.product, required this.press});

  final Product product;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: press,
      child: Container(
        decoration: BoxDecoration(
          color: darkColorScheme.inverseSurface,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: Hero(
                    tag: product.name,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8), // Image border
                      child: Image.asset(product.image),
                    ),
                  ),
                  title: Text(product.name, style: textTheme
                    .titleLarge
                    ?.copyWith(color: colorTheme.secondary)),
                  subtitle: product.quantity == 0
                    ? Text("Out of stock", style: textTheme
                      .bodySmall
                      ?.copyWith(color: lightCustomColors.sourceSuccess))
                    : Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: kDefaultPadding),
                          child: Text("In-stock", style: textTheme
                            .bodySmall
                            ?.copyWith(color: lightCustomColors.sourceSuccess)),
                        ),
                        Text("${product.quantity} in stock", style: textTheme
                          .bodySmall),
                      ],
                    )
                    ,
                  trailing: Text("${product.price ?? "N/A"}/unit", style: textTheme
                    .bodyLarge
                    ?.copyWith(color: colorTheme.secondary)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Additionnal Information", style: textTheme
                          .bodyLarge
                          ?.copyWith(color: colorTheme.secondary)),
                  ),
                  product.specialHandling == null
                  ? Text("Non renseigné", style: textTheme
                      .bodyMedium
                      ?.copyWith(color: colorTheme.secondary))
                  : Row(
                    children: <Widget>[
                      Text("${product.specialHandling!.capitalize()} : ", style: textTheme
                            .bodyMedium
                            ?.copyWith(color: colorTheme.secondary)),
                      Text("infos", style: textTheme
                            .bodyMedium
                            ?.copyWith(color: colorTheme.secondary)),
                    ],
                  ),                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}