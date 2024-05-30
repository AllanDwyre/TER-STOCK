class ProductAddForm {
  final String? name;
  final String? category;
  final String? dimension;
  final String? weight;
  final String? price;
  final String? img;

  ProductAddForm({
    this.name,
    this.category,
    this.dimension,
    this.weight,
    this.price,
    this.img,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'categorie': category,
      'dimensions': dimension,
      'weight': weight,
      'price': price,
      'img': img,
    };
  }
}
