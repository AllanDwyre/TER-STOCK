import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/utils/widgets/search_bar.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({
    super.key,
  });

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> {
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
              const CustomSearchBar(
                myLabelText: "Search product, supplier, order",
                myOnChanged: null,
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
