import 'package:flutter/material.dart';
import 'package:hive_stock/product/views/add_product_body.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddProductPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("New Product"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const AddProductBody(),
    );
  }
}
