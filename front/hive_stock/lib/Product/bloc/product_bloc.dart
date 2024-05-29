import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive_stock/product/models/movement_chart.dart';
import 'package:hive_stock/product/models/product.dart';
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
    on<ProductFetchedMovement>(_onProductFectchMovement);
  }

  FutureOr<void> _onProductFectch(
      ProductFetched event, Emitter<ProductState> emit) async {
    final product = await _tryGetProduct(event.id);

    emit(
      state.copyWith(product: product),
    );
  }

  Future<Product> _tryGetProduct(int id) async {
    try {
      logger.t('Product Fetching ...');

      return await _productRepository.getProduct(id);
    } catch (e) {
      logger.e('$e', error: 'Product Fetching Stack');
      throw Exception('error fetching product: $e');
    }
  }

  FutureOr<void> _onProductFectchMovement(
      ProductFetchedMovement event, Emitter<ProductState> emit) async {
    try {
      logger.t('Product chart movement fetching ...');

      List<MovementChart> values = await _productRepository.getMovementChart(
          productId: state.product!.productId!);
      var x = values.asMap();
      List<BarChartGroupData> data = x.entries.map((entry) {
        int index = entry.key;
        var el = entry.value;
        return BarChartGroupData(x: index, barRods: [
          BarChartRodData(toY: el.sales?.toDouble() ?? 0),
          BarChartRodData(toY: el.purchases?.toDouble() ?? 0),
        ]);
      }).toList();
      logger.d(data);

      emit(state.copyWith(barGroups: data));
    } catch (e) {
      logger.e('$e', error: 'Product chart movement Fetching Stack');
      throw Exception('error fetching chart movement: $e');
    }
  }
}
