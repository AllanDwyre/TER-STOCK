import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/product/bloc/product_bloc.dart';
import 'package:hive_stock/product/repository/product_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';

import 'product_body.dart';

class ProductPage extends StatefulWidget {
  const ProductPage(
      {super.key,
      required this.produitId,
      this.isFullHeader = true,
      this.scrollController});
  final int produitId;
  final bool isFullHeader;
  final ScrollController? scrollController;

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
    _productRepository = ProductRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    logger.t('Access to produc n°${widget.produitId}');
    return Builder(builder: (context) {
      if (widget.isFullHeader) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          //resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,

          body: BlocProvider(
            create: (context) =>
                ProductBloc(productRepository: _productRepository)
                  ..add(ProductFetched(id: widget.produitId)),
            child: ProductBody(
              isFullHeader: widget.isFullHeader,
            ),
          ),
        );
      }
      return BlocProvider(
        create: (context) => ProductBloc(productRepository: _productRepository)
          ..add(ProductFetched(id: widget.produitId)),
        child: ProductBody(
          isFullHeader: widget.isFullHeader,
          scrollController: widget.scrollController,
        ),
      );
    });
  }
}
