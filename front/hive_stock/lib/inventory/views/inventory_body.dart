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
          .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      child: SizedBox(
        height: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MySearchBar(
              myLabelStyle: const TextStyle(fontSize:12),
              myLabelText: "Search product, supplier, order",
              myOnChanged: onQueryChanged,
              myHeight: 110.0,
            ),
            if (searchQuery == '') Container(
              padding: const EdgeInsets.fromLTRB(kDefaultPadding, 0, kDefaultPadding, kDefaultPadding/2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Overall Inventory",
                  style: textTheme
                  .headlineSmall
                  ?.copyWith(color: colorTheme.onBackground),
                ),
              ),
            ),
            if (searchQuery == '') Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: size.width/2 - kDefaultPadding,
                        width: size.width/2 - kDefaultPadding,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorTheme.secondaryContainer,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(kDefaultPadding/2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Total Products",
                                        style: textTheme.titleLarge?.copyWith(color: const Color.fromRGBO(225, 145, 51, 1)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "${products.length}",
                                        style: textTheme.titleLarge?.copyWith(color: colorTheme.primary),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ),
                      SizedBox(
                        height: size.width/2 - kDefaultPadding,
                        width: size.width/2 - kDefaultPadding,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorTheme.secondaryContainer,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child:Container(
                              margin: const EdgeInsets.all(kDefaultPadding/2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Categories",
                                        style: textTheme.titleLarge?.copyWith(color: const Color.fromRGBO(21, 112, 239, 1)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "${products.map((el) => el.category).toSet().toList().length}",
                                        style: textTheme.titleLarge?.copyWith(color: colorTheme.primary),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ),
                    ]
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: size.width/2 - kDefaultPadding,
                        width: size.width/2 - kDefaultPadding,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorTheme.secondaryContainer,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child:Container(
                              margin: const EdgeInsets.all(kDefaultPadding/2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Top Selling",
                                        style: textTheme.titleLarge?.copyWith(color: const Color.fromRGBO(132, 94, 188, 1)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        products.reduce((curr, next) => curr.quantity > next.quantity? curr: next).name,
                                        style: textTheme.titleLarge?.copyWith(color: colorTheme.primary),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ),
                      SizedBox(
                        height: size.width/2 - kDefaultPadding,
                        width: size.width/2 - kDefaultPadding,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Container(
                            decoration: BoxDecoration(
                              color: colorTheme.secondaryContainer,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                            ),
                            child:Container(
                              margin: const EdgeInsets.all(kDefaultPadding/2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "Low Stocks",
                                        style: textTheme.titleLarge?.copyWith(color: const Color.fromRGBO(243, 105, 96, 1)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        "${products.map((el) => (el.quantity<1 ? 1 : 0)).reduce((value, element) => value+element)}",
                                        style: textTheme.titleLarge?.copyWith(color: colorTheme.primary),
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ),
                    ]
                  ),
                ],
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
                  child: searchResults.isEmpty
                    ? const Text("No result")
                    : GridView.builder(
                        itemCount: searchResults.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: kDefaultPadding,
                          crossAxisSpacing: kDefaultPadding,
                          childAspectRatio: 3,
                        ),
                        itemBuilder: (context, index) => ItemCard(
                          product: searchResults[index],
                          press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(product: searchResults[index]),
                            ),
                          ),
                        ),
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}