import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_stock/product/repository/product_repository.dart';

part 'add_or_edit_product_event.dart';
part 'add_or_edit_product_state.dart';

class AddOrEditProductBloc
    extends Bloc<AddOrEditProductEvent, AddOrEditProductState> {
  AddOrEditProductBloc(ProductRepository productRepository)
      : _productRepository = productRepository,
        super(AddOrEditProductState()) {
    on<OnAddProduct>(_onAddProduct);
    on<OnEditProduct>(_onEditProduct);
    on<OnInformationChangeProduct>(_onInformationChangeProduct);
  }
  final ProductRepository _productRepository;

  FutureOr<void> _onAddProduct(event, emit) {}
  FutureOr<void> _onEditProduct(event, emit) {}
  FutureOr<void> _onInformationChangeProduct(event, emit) {}
}