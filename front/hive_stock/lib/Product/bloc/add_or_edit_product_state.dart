part of 'add_or_edit_product_bloc.dart';

class AddOrEditProductState extends Equatable {
  final FormzSubmissionStatus status;
  final bool isValid;
  final int productId;
  final Name name;
  final Category category;
  final Dimension dimension;
  final Weight weight;
  final Price price;

  const AddOrEditProductState(
      {this.status = FormzSubmissionStatus.initial,
      this.isValid = false,
      this.productId = -1,
      this.name = const Name.pure(),
      this.category = const Category.pure(),
      this.dimension = const Dimension.pure(),
      this.weight = const Weight.pure(),
      this.price = const Price.pure()});

  AddOrEditProductState copyWith(
      {FormzSubmissionStatus? status,
      bool? isValid,
      int? productId,
      Name? name,
      Category? category,
      Dimension? dimension,
      Weight? weight,
      Price? price}) {
    return AddOrEditProductState(
      status: status ?? this.status,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      category: category ?? this.category,
      dimension: dimension ?? this.dimension,
      weight: weight ?? this.weight,
      price: price ?? this.price,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props =>
      [status, isValid, productId, name, category, dimension, weight, price];
}
