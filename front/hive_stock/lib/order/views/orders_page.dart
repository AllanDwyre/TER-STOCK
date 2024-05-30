import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_stock/home/views/navigation_menu.dart';
import 'package:hive_stock/order/bloc/orders_bloc.dart';
import 'package:hive_stock/order/repository/order_repository.dart';
import 'package:hive_stock/scanner/views/scanner_page.dart';
import 'package:hive_stock/utils/constants/customs_icons.dart';

import 'orders_body.dart';

class OrdersPage extends StatelessWidget implements Menu {
  const OrdersPage({super.key});

  @override
  List<Widget> appBarActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: SvgPicture.asset(CustomIcons.scan),
        onPressed: () => Navigator.push(context, ScannerScreen.route()),
      ),
    ];
  }

  @override
  Widget? floatingButton(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return FloatingActionButton.extended(
      label: Text("Add Order", style: textTheme.bodySmall),
      icon: const Icon(Icons.add),
      onPressed: null, //() => Navigator.push(context, AddProductPage.route()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => OrderRepository(),
      child: BlocProvider(
        create: (context) => OrdersBloc(
            orderRepository: RepositoryProvider.of<OrderRepository>(context))
          ..add(OrdersFetched())
          ..add(OrdersStatsFetched()),
        child: const OrdersBody(),
      ),
    );
  }
}
