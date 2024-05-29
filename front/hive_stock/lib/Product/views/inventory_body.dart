import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/product/bloc/inventory_bloc.dart';
import 'package:hive_stock/product/models/product_inventory.dart';
import 'package:hive_stock/product/views/product_page.dart';
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
    if (_isBottom) context.read<InventoryBloc>().add(InventoryFetched());
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
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomSearchBar(
                myLabelText: "Search product, supplier, order",
                myOnChanged: onQueryChanged,
              ),
              _OverallInventoryWidget(isVisible: searchQuery.isEmpty),
              const _ProductTitleWFilter(),
            ],
          ),
        ),
        BlocBuilder<InventoryBloc, InventoryState>(
          builder: (context, state) {
            switch (state.status) {
              case InventoryStatus.failure:
                return const Center(child: Text('failed to fetch products'));
              case InventoryStatus.success:
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
                        : ProductCard(
                            productInventory: state.products[index],
                            onTap: () => Navigator.of(context).push(
                                ProductPage.route(
                                    produitId: state
                                        .products[index].product.productId!)),
                          );
                  },
                  itemCount: state.hasReachedMax
                      ? state.products.length
                      : state.products.length +
                          1, // +1 to add the bottom loader
                );
              case InventoryStatus.initial:
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 100),
        )
      ],
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
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
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
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
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
                  Row(
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
          ],
        ),
      ),
    );
  }
}
