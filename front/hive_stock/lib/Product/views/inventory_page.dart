import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:hive_stock/home/views/navigation_menu.dart";
import "package:hive_stock/product/bloc/inventory_bloc.dart";
import "package:hive_stock/product/repository/product_repository.dart";
import "package:hive_stock/product/views/add_product_page.dart";
import "package:hive_stock/product/views/inventory_body.dart";
import "package:hive_stock/scanner/views/scanner_page.dart";

class InventoryPage extends StatefulWidget implements Menu {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();

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
      label: Text("Add a product", style: textTheme.bodySmall),
      icon: const Icon(Icons.add),
      onPressed: () => Navigator.push(context, AddProductPage.route()),
    );
  }
}

class _InventoryPageState extends State<InventoryPage> {
  // static List<Product> productList = products;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ProductRepository(),
      child: BlocProvider(
        create: (context) => InventoryBloc(productRepository: RepositoryProvider.of<ProductRepository>(context))
          ..add(InventoryFetched()), // we do the initial fetch
        child: const InventoryBody(),
      ),
    );
  }
}
