import 'package:flutter/material.dart';
import 'package:hive_stock/product/views/add_product_body.dart';


class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
