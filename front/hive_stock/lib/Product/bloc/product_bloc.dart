import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_stock/product/models/product_inventory.dart';
import 'package:hive_stock/product/repository/product_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const ProductState()) {
    on<ProductFetched>(_onProductFectch);
  }

  FutureOr<void> _onProductFectch(
      ProductFetched event, Emitter<ProductState> emit) async {
    final product = await _tryGetProduct(event.id);

    emit(
      state.copyWith(productdetails: product),
    );
  }

  Future<ProductInventory> _tryGetProduct(int id) async {
    try {
      logger.t('Product Fetching ...');

      return await _productRepository.getProduct(id);
    } catch (e) {
      logger.e('$e', error: 'Product Fetching Stack');
      throw Exception('error fetching product: $e');
    }
  }
}
