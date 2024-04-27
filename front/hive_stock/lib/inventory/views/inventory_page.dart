import "package:flutter/material.dart";

import "package:flutter_svg/svg.dart";
import "package:hive_stock/inventory/views/inventory_body.dart";
import "package:hive_stock/product/models/product.dart";
import "package:hive_stock/product/views/add_product_page.dart";
import "package:hive_stock/scanner/views/scanner_page.dart";
import "package:hive_stock/utils/constants/padding.dart";

class InventoryScreen extends StatelessWidget {

  static List<Product> productList = products;

  const InventoryScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const InventoryScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: InventoryBody(productList),
    );
  }

  AppBar buildAppBar(BuildContext context){
    ColorScheme colorTheme = Theme.of(context).colorScheme;
    return AppBar(
      backgroundColor: colorTheme.onPrimary,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/hivestock_logo.svg"),
        onPressed: () {},
      ),
      title:const Text("Hivestock"),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.push(
            context,
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
            child: Center(child: Text('+ Add Product', style:TextStyle(color:colorTheme.onPrimary, fontSize: 12))),
          ),
        ),
        IconButton(
          icon:const Icon(Icons.qr_code_scanner),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScannerScreen(),
            ),
          ),
        ),
        const SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}