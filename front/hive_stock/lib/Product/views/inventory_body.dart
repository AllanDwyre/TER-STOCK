import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/product/bloc/product_bloc.dart';
import 'package:hive_stock/product/models/product_inventory.dart';
import 'package:hive_stock/utils/widgets/item_card.dart';
import 'package:hive_stock/utils/widgets/search_bar.dart';
import 'package:hive_stock/utils/constants/padding.dart';

import 'bottom_loader.dart';
import 'card_stat.dart';

class InventoryBody extends StatefulWidget {
  const InventoryBody({super.key, this.productList});

  final List<ProductInventory>? productList;

  @override
  State<InventoryBody> createState() => _InventoryBodyState();
}

class _InventoryBodyState extends State<InventoryBody> {
  // List<Product> searchResults = List<Product>.from(products);
  String searchQuery = '';
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<ProductBloc>().add(ProductFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void onQueryChanged(String query) {
    // searchQuery = query;
    // setState(() {
    //   searchResults = products
    //       .where(
    //           (item) => item.name.toLowerCase().contains(query.toLowerCase()))
    //       .toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
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
              const _ProductTitleWFilter(),
            ],
          ),
        ),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            switch (state.status) {
              case ProductStatus.failure:
                return const Center(child: Text('failed to fetch products'));
              case ProductStatus.success:
                if (state.products.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                          'No products, go maybe in the orders tab to gets some product!'),
                    ),
                  );
                }
                return SliverList.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.products.length
                        ? const BottomLoader()
                        : ProductCard(productInventory: state.products[index]);
                  },
                  itemCount: state.hasReachedMax
                      ? state.products.length
                      : state.products.length +
                          1, // +1 to add the bottom loader
                );
              case ProductStatus.initial:
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ],
    );
  }
}

class _ProductsListWidget extends StatelessWidget {
  const _ProductsListWidget({this.products});
  final List<ProductInventory>? products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Column(
        children: [
          _ProductTitleWFilter(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: products?.isEmpty ?? true
                  ? const Text("No result")
                  : ListView.builder(
                      itemCount: products?.length,
                      itemBuilder: (context, index) => ProductCard(
                        productInventory: products![index],
                        // press: () => Navigator.push(
                        //   context,
                        //   // TODO : Ne respecte pas la convention de navigation
                        //   MaterialPageRoute(
                        //     builder: (context) => ProductPage(
                        //       product: products![index],
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductTitleWFilter extends StatelessWidget {
  const _ProductTitleWFilter();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return Container(
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
                    icon: const Icon(Icons.filter_alt, color: Colors.black),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
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
            const Row(
              children: [
                CardStat(
                  title: 'Total Products',
                  titleColor: Color.fromRGBO(225, 145, 51, 1),
                  data: "2158", // TODO : fecth data from backend
                ),
                CardStat(
                  title: 'Categories',
                  titleColor: Color.fromRGBO(21, 112, 239, 1),
                  data: "30", // TODO : fecth data from backend
                ),
              ],
            ),
            const Row(
              children: [
                CardStat(
                  title: 'Top Selling',
                  titleColor: Color.fromRGBO(132, 94, 188, 1),
                  data: 'GodZilla',
                ), // TODO : fecth data from backend
                CardStat(
                  title: 'Low Stocks',
                  titleColor: Color.fromRGBO(243, 105, 96, 1),
                  data: "5",
                ), // TODO : fecth data from backend
              ],
            ),
          ],
        ),
      ),
    );
  }
}
