import 'package:flutter/material.dart';

import '../models/product.dart';
import 'product_body.dart';

class ProductScreen extends StatelessWidget {

  final Product product;

  const ProductScreen(this.product, {super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => ProductScreen(products.first));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 30.0),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ProductBody(product),
    );
  }
}
