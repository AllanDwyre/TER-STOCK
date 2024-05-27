import 'package:flutter/material.dart';
import 'package:hive_stock/product/views/inventory_page.dart';
import 'package:hive_stock/utils/constants/padding.dart';
import 'package:hive_stock/home/views/bar_chart.dart';
import 'package:hive_stock/utils/widgets/search_bar.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<Object>? orders;
  List<Object>? searchResults;
  String searchQuery = '';

  // ! TODO : error here
  void onQueryChanged(String query) {
    searchQuery = query;
    setState(() {
      searchResults = orders!
          .where((item) => item.hashCode
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSearchBar(
            myLabelText: "Search product, supplier, order",
            myOnChanged: onQueryChanged,
          ),
          // * Inventory overall stats
          const InventorySummary(),
          const ProductSummary(),
          const SalesAndPurchases(),
        ],
      ),
    );
  }
}

class SalesAndPurchases extends StatelessWidget {
  const SalesAndPurchases({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Container(
        width: size.width - 2 * kDefaultPadding,
        decoration: BoxDecoration(
          color: colorTheme.outlineVariant,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding / 2),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.fromLTRB(0, 0, 0, kDefaultPadding / 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sales & Purchases",
                    style: textTheme.titleMedium?.copyWith(color: Colors.black),
                  ),
                ),
              ),
              const BarChartWidget(), // https://fluttergems.dev/packages/fl_chart/
            ],
          ),
        ),
      ),
    );
  }
}

class ProductSummary extends StatelessWidget {
  const ProductSummary({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InventoryPage(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Container(
          width: size.width - 2 * kDefaultPadding,
          decoration: BoxDecoration(
            color: colorTheme.outlineVariant,
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(0, 0, 0, kDefaultPadding / 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Product Summary",
                      style:
                          textTheme.titleMedium?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  color: const Color.fromARGB(27, 36, 184, 241),
                                  child: const Icon(Icons.person_outlined,
                                      color:
                                          Color.fromARGB(255, 36, 184, 241))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "31",
                                style: textTheme.titleMedium
                                    ?.copyWith(color: colorTheme.primary),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Number of Supplier",
                                style: textTheme.titleSmall
                                    ?.copyWith(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        width: 50,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  color:
                                      const Color.fromARGB(25, 177, 174, 241),
                                  child: const Icon(Icons.list_alt,
                                      color:
                                          Color.fromARGB(255, 129, 122, 243))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "21",
                                style: textTheme.titleMedium
                                    ?.copyWith(color: colorTheme.primary),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Number of Categories",
                                style: textTheme.titleSmall
                                    ?.copyWith(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InventorySummary extends StatelessWidget {
  const InventorySummary({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InventoryPage(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding / 2),
        child: Container(
          width: size.width - 2 * kDefaultPadding,
          decoration: BoxDecoration(
            color: colorTheme.outlineVariant,
            borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(0, 0, 0, kDefaultPadding / 2),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Inventory Summary",
                      style:
                          textTheme.titleMedium?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  color: const Color.fromARGB(27, 255, 197, 37),
                                  child: const Icon(Icons.inventory_2_outlined,
                                      color:
                                          Color.fromARGB(255, 240, 179, 47))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "868",
                                style: textTheme.titleMedium
                                    ?.copyWith(color: colorTheme.primary),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "Quantity in Hand",
                                style: textTheme.titleSmall
                                    ?.copyWith(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        width: 50,
                        thickness: 1,
                        indent: 0,
                        endIndent: 0,
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                  color:
                                      const Color.fromARGB(25, 177, 174, 241),
                                  child: const Icon(Icons.pending_actions,
                                      color:
                                          Color.fromARGB(255, 129, 122, 243))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "200",
                                style: textTheme.titleMedium
                                    ?.copyWith(color: colorTheme.primary),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(
                                "To be Received",
                                style: textTheme.titleSmall
                                    ?.copyWith(color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
