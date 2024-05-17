class Product {
  int productId;
  String name;
  String description;
  double unitPrice;
  double weight;
  String dimensions;
  String warehouse;
  String barcode;
  int categoryId;
  int locationId;
  int supplierId;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.weight,
    required this.dimensions,
    required this.warehouse,
    required this.barcode,
    required this.categoryId,
    required this.locationId,
    required this.supplierId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['PRODUIT_ID'],
      name: json['NOM'],
      description: json['DESCR'],
      unitPrice: double.parse(json['PRIX_UNIT']),
      weight: double.parse(json['POIDS'].replaceAll(RegExp(r'[^0-9.]'), '')),
      dimensions: json['DIMENSIONS'],
      warehouse: json['MAGASIN_ENTREPOT'],
      barcode: json['CODE_BARRE_PRODUIT'],
      categoryId: json['CATEGORIE_ID'],
      locationId: json['EMPLACEMENT_ID'],
      supplierId: json['FOURNISSEUR_ID'],
    );
  }
}
