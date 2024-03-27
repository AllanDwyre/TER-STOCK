import 'package:flutter/material.dart';

import '../models/product.dart';
import '../../components/product_body.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey,
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
