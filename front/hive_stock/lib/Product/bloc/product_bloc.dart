import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';
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
  final BridgeRepository bridge;

  ProductBloc({required this.bridge}) : super(const ProductState()) {
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

  // TODO : product repository
  Future<List<Product>> _fetchProducts([int startIndex = 0]) async {
    // final response = await httpClient.get(
    //   Uri.https(
    //     'jsonplaceholder.typicode.com',
    //     '/posts',
    //     <String, String>{'_start': '$startIndex', '_limit': '$_productLimit'},
    //   ),
    // );

    // if (response.statusCode == 200) {
    //   final body = json.decode(response.body) as List;
    //   return body.map((dynamic json) {
    //     final map = json as Map<String, dynamic>;
    //     return Product(
    //       id: map['id'] as int,
    //       title: map['title'] as String,
    //       body: map['body'] as String,
    //     );
    //   }).toList();
    // }
    // throw Exception('error fetching posts');
    throw UnimplementedError("It's not currently Implemented");
  }
}
