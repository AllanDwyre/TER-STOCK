import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "package:flutter_svg/svg.dart";
import "package:hive_stock/product/bloc/inventory_bloc.dart";
import "package:hive_stock/product/repository/product_repository.dart";
import "package:hive_stock/product/views/inventory_body.dart";
import "package:hive_stock/product/views/add_product_page.dart";
import "package:hive_stock/scanner/views/scanner_page.dart";
import "package:hive_stock/utils/app/bridge_repository.dart";
import "package:hive_stock/utils/constants/padding.dart";
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(context),
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
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: colorTheme.onPrimary,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/hivestock_logo.svg"),
        onPressed: () {},
      ),
      title: const Text("Hivestock"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.push(
            context,
            //TODO : ne respecte pas les normes
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          ),
          child: Container(
            height: 25,
            width: 100,
            decoration: BoxDecoration(
              color: colorTheme.primary,
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: Center(
                child: Text('+ Add Product',
                    style:
                        TextStyle(color: colorTheme.onPrimary, fontSize: 12))),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () => Navigator.push(context, ScannerScreen.route()),
        ),
        const SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}
