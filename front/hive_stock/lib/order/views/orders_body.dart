import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/order/bloc/orders_bloc.dart';
import 'package:hive_stock/order/models/orders_stats.dart';
import 'package:hive_stock/order/views/order_page.dart';
import 'package:hive_stock/utils/widgets/bottom_loader.dart';
import 'package:hive_stock/utils/widgets/card_stat.dart';
import 'package:hive_stock/utils/widgets/custom_tab_bar.dart';
import 'package:hive_stock/utils/widgets/search_bar.dart';

import 'order_card.dart';

class OrdersBody extends StatefulWidget {
  const OrdersBody({
    super.key,
  });

  @override
  State<OrdersBody> createState() => _OrdersBodyState();
}

class _OrdersBodyState extends State<OrdersBody> with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<OrdersBloc>().add(OrdersFetched());
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
        const SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomSearchBar(
                myLabelText: "Search product, supplier, order",
                myOnChanged: null,
              ),
              _OverallStatsWidget(
                isVisible: true,
              ),
            ],
          ),
        ),
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          primary: false,
          title: CustomTabBar(
            tabController: tabController,
            onTap: (index) =>
                context.read<OrdersBloc>().add(OrdersTypeChange(type: index)),
            tabs: const [
              Tab(text: "All"),
              Tab(text: "Entry"),
              Tab(text: "Exit"),
            ],
          ),
        ),
        BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            switch (state.status) {
              case OrdersStatus.failure:
                return const Center(child: Text('failed to fetch orders'));
              case OrdersStatus.success:
                if (state.orders.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      alignment: Alignment.center,
                      child: const Text('No orders, add some!'),
                    ),
                  );
                }
                return SliverList.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.orders.length
                        ? const BottomLoader()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: OrderCard(
                              order: state.orders[index],
                              onTap: () => Navigator.of(context).push(
                                  OrderPage.route(id: state.orders[index].id!)),
                            ),
                          );
                  },
                  itemCount: state.hasReachedMax
                      ? state.orders.length
                      : state.orders.length + 1, // +1 to add the bottom loader
                );
              case OrdersStatus.initial:
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

class _OverallStatsWidget extends StatelessWidget {
  final bool isVisible;

  const _OverallStatsWidget({required this.isVisible});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorTheme = Theme.of(context).colorScheme;

    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        OrdersStats? stats = state.stats;
        return Visibility(
          visible: isVisible,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Overall Orders",
                  style: textTheme.headlineSmall
                      ?.copyWith(color: colorTheme.onBackground),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CardStat(
                            title: 'Total Order',
                            titleColor: const Color.fromRGBO(21, 112, 239, 1),
                            data: "${stats?.totalOrder}",
                          ),
                          CardStat(
                            title: 'Total Received',
                            titleColor: const Color.fromRGBO(225, 145, 51, 1),
                            data: "${stats?.totalReceived}",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CardStat(
                            title: 'Total Returned',
                            titleColor: const Color.fromRGBO(132, 94, 188, 1),
                            data: "${stats?.totaltReturned}",
                          ),
                          CardStatDuo(
                            title: 'On the way',
                            titleColor: const Color.fromRGBO(243, 105, 96, 1),
                            label: 'Entry',
                            label1: 'Exit',
                            data: "${stats?.totalFournisseur}",
                            data1: "${stats?.totalClient}",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
