import 'package:flutter/material.dart';
import 'package:hive_stock/home/views/navigation_menu.dart';
import 'package:hive_stock/scanner/views/scanner_page.dart';

class OrdersPage extends StatelessWidget implements Menu {
  const OrdersPage({super.key});

  @override
  List<Widget> appBarActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.qr_code_scanner),
        onPressed: () => Navigator.push(context, ScannerScreen.route()),
      ),
    ];
  }

  @override
  Widget? floatingButton(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return FloatingActionButton.extended(
      label: Text("Add order", style: textTheme.bodySmall),
      icon: const Icon(Icons.add),
      onPressed: null, //() => Navigator.push(context, AddProductPage.route()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
