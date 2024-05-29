import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/product/models/product_form_validation.dart';
import 'package:hive_stock/product/repository/product_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';

part 'add_or_edit_product_event.dart';
part 'add_or_edit_product_state.dart';

class AddOrEditProductBloc
    extends Bloc<AddOrEditProductEvent, AddOrEditProductState> {
  AddOrEditProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(const AddOrEditProductState()) {
    on<OnSumbitProduct>(_onSumbitProduct);
    on<OnAddImg>(_onAddImg);
    // on<OnEditProductFetch>(_onEditProductFecth);
    on<OnInformationChangeProduct>(_onInformationChangeProduct);
  }
  final ProductRepository _productRepository;

  FutureOr<void> _onAddImg(
    OnAddImg event, Emitter emit) {
    emit(
      state.copyWith(
        img: event.img,
        pathImg: event.pathImg,
        titleImg: event.titleImg,
      ),
    );
  }

  FutureOr<void> _onInformationChangeProduct(
      OnInformationChangeProduct event, Emitter emit) {
    // on modifie les valeurs
    emit(
      state.copyWith(
        name: Name.dirty(event.name ?? state.name.value),
        category: Category.dirty(event.category ?? state.category.value),
        dimension: Dimension.dirty(event.dimension ?? state.dimension.value),
        weight: Weight.dirty(event.weight ?? state.weight.value),
        price: Price.dirty(event.price ?? state.price.value),
      ),
    );
    emit(
      state.copyWith(
        isValid: Formz.validate(
          [
            state.name,
            state.category,
            state.dimension,
            state.weight,
            state.price,
          ],
        ),
      ),
    );
  }

  FutureOr<void> _onSumbitProduct(OnSumbitProduct event, Emitter emit) async {
    Product product = Product(
      name: state.name.value,
      unitPrice: state.name.value,
      weight: state.weight.value,
      dimensions: state.dimension.value,
      img: state.img
    );
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    int result = await _tryAddProduct(product);

    emit(
      state.copyWith(
        status: result >= 0
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
        productId: result,
      ),
    );
  }

  Future<int> _tryAddProduct(Product product) async {
    try {
      return await _productRepository.addProduct(product);
    } catch (e) {
      logger.e(e, error: 'Trace :');
      return -1;
    }
  }

  // FutureOr<void> _onEditProductFecth(event, emit) {}
}
