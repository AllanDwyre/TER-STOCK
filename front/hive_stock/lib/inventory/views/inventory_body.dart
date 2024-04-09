import 'package:flutter/material.dart';
import 'package:hive_stock/inventory/models/item_card.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/product/views/product_page.dart';
import 'package:hive_stock/utils/constants/padding.dart';

class InventoryBody extends StatelessWidget {

  final List<Product> productList;

  const InventoryBody(this.productList, {super.key});

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // search bar tuto
        // https://www.dhiwise.com/post/flutter-search-bar-tutorial-for-building-a-powerful-search-functionality
        Container(
          height: 110,
          padding: const EdgeInsets.all(30),
          child: const TextField(
            decoration: InputDecoration(
              labelStyle:TextStyle(fontSize:12),
              labelText: "Search product, supplier, order",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Products",
                        style: textTheme
                        .headlineSmall
                        ?.copyWith(color: colorTheme.onBackground),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.filter_alt, color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: kDefaultPadding,
                  crossAxisSpacing: kDefaultPadding,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) => ItemCard(
                  product: products[index],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(product: products[index]),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}