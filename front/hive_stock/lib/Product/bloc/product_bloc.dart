import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_stock/product/models/product_inventory.dart';
import 'package:hive_stock/product/repository/product_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:stream_transform/stream_transform.dart';

part 'product_event.dart';
part 'product_state.dart';

const _productLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

/// Optimisation qui permet d'ignorer les nouveau events tant que l'éxecution de l'évent actuelle n'est pas finis afin d'éviter de spammer inutilement notre Backend.
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const ProductState()) {
    on<ProductFetched>(_onProductFetched);
  }

  Future<void> _onProductFetched(
      ProductFetched event, Emitter<ProductState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ProductStatus.initial) {
        final products = await _fetchProducts();
        return emit(state.copyWith(
          status: ProductStatus.success,
          products: products,
          hasReachedMax: false,
        ));
      }
      final products = await _fetchProducts(state.products.length);
      emit(products.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ProductStatus.success,
              products: List.of(state.products)..addAll(products),
              hasReachedMax: false,
            ));
    } on Exception catch (e) {
      emit(state.copyWith(status: ProductStatus.failure));
      logger.e('Erreur de récupération de list produits\n=> $e',
          error: 'Product Bloc');
    }
  }

  Future<List<ProductInventory>> _fetchProducts([int startIndex = 0]) async {
    try {
      final List<ProductInventory> products = await _productRepository
          .fetchProducts(start: startIndex, limit: _productLimit);

      return products;
    } catch (e) {
      logger.e("error fetching posts: $e", error: 'Product Bloc');
      throw Exception('error fetching posts: $e');
    }
  }
}
