import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:flutter_svg/svg.dart";
import "package:hive_stock/home/home.dart";
import "package:hive_stock/product/bloc/inventory_bloc.dart";
import "package:hive_stock/product/repository/product_repository.dart";
import "package:hive_stock/product/views/add_product_page.dart";
import "package:hive_stock/product/views/inventory_body.dart";
import "package:hive_stock/scanner/views/scanner_page.dart";
import "package:hive_stock/utils/app/bridge_repository.dart";
import "package:hive_stock/utils/widgets/bottom_nav_bar.dart";

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const InventoryPage());
  }

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  // static List<Product> productList = products;
  late final ProductRepository _productRepository;

  @override
  void initState() {
    _productRepository = ProductRepository(
        bridge: RepositoryProvider.of<BridgeRepository>(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add a product", style: textTheme.bodySmall),
        icon: const Icon(Icons.add),
        onPressed: () => Navigator.push(context, AddProductPage.route()),
      ),
      body: RepositoryProvider.value(
        value: _productRepository,
        child: BlocProvider(
          create: (context) =>
              InventoryBloc(productRepository: _productRepository)
                ..add(InventoryFetched()), // we do the initial fetch
          child: const InventoryBody(),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(initialTab: 1),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/hivestock_logo.svg"),
        onPressed: () => Navigator.pushAndRemoveUntil(
            context, HomePage.route(), (route) => false),
      ),
      title: Text("Hivestock", style: textTheme.titleMedium),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () => Navigator.push(context, ScannerScreen.route()),
        ),
      ],
    );
  }
}
