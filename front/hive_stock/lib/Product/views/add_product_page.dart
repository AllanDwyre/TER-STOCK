import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_stock/product/bloc/add_or_edit_product_bloc.dart';
import 'package:hive_stock/product/repository/product_repository.dart';
import 'package:hive_stock/product/views/add_product_body.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const AddProductPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text("New Product"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RepositoryProvider(
        create: (context) => ProductRepository(
            bridge: RepositoryProvider.of<BridgeRepository>(context)),
        child: BlocProvider(
          create: (context) => AddOrEditProductBloc(
            productRepository:
                RepositoryProvider.of<ProductRepository>(context),
          ),
          child: const AddProductBody(),
        ),
      ),
    );
  }
}
