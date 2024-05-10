import 'package:flutter/material.dart';
import 'package:hive_stock/utils/widgets/item_card.dart';
import 'package:hive_stock/utils/widgets/search_bar.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/product/views/product_page.dart';
import 'package:hive_stock/utils/constants/padding.dart';

class InventoryBody extends StatefulWidget {
  const InventoryBody(this.productList, {super.key});

  final List<Product> productList;

  @override
  State<InventoryBody> createState() => _InventoryBodyState();
}

class _InventoryBodyState extends State<InventoryBody> {
  List<Product> searchResults = List<Product>.from(products);
  String searchQuery = '';

  void onQueryChanged(String query) {
    searchQuery = query;
    setState(() {
      searchResults = products
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MySearchBar(
            myLabelStyle: const TextStyle(fontSize: 12),
            myLabelText: "Search product, supplier, order",
            myOnChanged: onQueryChanged,
            myHeight: 110.0,
          ),
          _OverallInventoryWidget(isVisible: searchQuery.isEmpty),
          _ProductsListWidget(products: searchResults),
        ],
      ),
    );
  }
}

class _ProductsListWidget extends StatelessWidget {
  const _ProductsListWidget({required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: double.maxFinite,
      child: Column(
        children: [
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
                          style: textTheme.headlineSmall
                              ?.copyWith(color: colorTheme.onBackground),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon:
                              const Icon(Icons.filter_alt, color: Colors.black),
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
              child: products.isEmpty
                  ? const Text("No result")
                  : GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: kDefaultPadding,
                        crossAxisSpacing: kDefaultPadding,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (context, index) => ItemCard(
                        product: products[index],
                        press: () => Navigator.push(
                          context,
                          // TODO : Ne respecte pas la convention de navigation
                          MaterialPageRoute(
                            builder: (context) => ProductPage(
                              product: products[index],
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OverallInventoryWidget extends StatelessWidget {
  const _OverallInventoryWidget({required this.isVisible});
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Visibility(
      visible: isVisible,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall Inventory",
              style: textTheme.headlineSmall
                  ?.copyWith(color: colorTheme.onBackground),
            ),
            Row(
              children: [
                CardStat(
                  title: 'Total Products',
                  titleColor: const Color.fromRGBO(225, 145, 51, 1),
                  data: "${products.length}",
                ),
                CardStat(
                  title: 'Categories',
                  titleColor: const Color.fromRGBO(21, 112, 239, 1),
                  data:
                      "${products.map((el) => el.category).toSet().toList().length}",
                ),
              ],
            ),
            Row(
              children: [
                CardStat(
                  title: 'Top Selling',
                  titleColor: const Color.fromRGBO(132, 94, 188, 1),
                  data: products
                      .reduce((curr, next) =>
                          curr.quantity > next.quantity ? curr : next)
                      .name,
                ),
                CardStat(
                  title: 'Low Stocks',
                  titleColor: const Color.fromRGBO(243, 105, 96, 1),
                  data:
                      "${products.map((el) => (el.quantity < 1 ? 1 : 0)).reduce((value, element) => value + element)}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardStat extends StatelessWidget {
  const CardStat({
    super.key,
    required this.title,
    required this.titleColor,
    required this.data,
  });

  final String title;
  final Color titleColor;
  final String? data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
        height: size.width / 2 - kDefaultPadding,
        width: size.width / 2 - kDefaultPadding,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              color: colorTheme.secondaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Container(
              margin: const EdgeInsets.all(kDefaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style:
                            textTheme.titleLarge?.copyWith(color: titleColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        data ?? "-",
                        style: textTheme.titleLarge
                            ?.copyWith(color: colorTheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
