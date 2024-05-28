import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/product/bloc/product_bloc.dart';
import 'package:hive_stock/product/repository/product_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';

import 'product_body.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.produitId});
  final int produitId;

  static Route<void> route({required int produitId}) {
    return MaterialPageRoute<void>(
      builder: (_) => ProductPage(
        produitId: produitId,
      ),
    );
  }

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late final ProductRepository _productRepository;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.t('Access to produc n°${widget.produitId}');
    return Scaffold(
      extendBodyBehindAppBar: true,
      //resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,

      body: BlocProvider(
        create: (context) => ProductBloc(productRepository: _productRepository)
          ..add(ProductFetched(id: widget.produitId)),
        child: const ProductBody(),
      ),
    );
  }
}


      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back_ios_new,
      //         color: Colors.white, size: 30.0),
      //     onPressed: () => Navigator.of(context).pop(),
      //   ),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),