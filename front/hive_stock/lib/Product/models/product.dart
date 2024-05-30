class Product {
  int? productId;
  String? name;
  String? description;
  String? unitPrice;
  String? weight;
  String? dimensions;
  String? warehouse;
  String? barcode;
  int? categoryId;
  int? locationId;
  int? supplierId;
  String? img;
  int? seuil;
  int? quantity;
  String? sku;
  String? classe;

  Product({
    this.productId,
    this.name,
    this.description,
    this.unitPrice,
    this.weight,
    this.dimensions,
    this.warehouse,
    this.barcode,
    this.categoryId,
    this.locationId,
    this.supplierId,
    this.img,
    this.seuil,
    this.quantity,
    this.sku,
    this.classe,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['PRODUIT_ID'] != null
          ? int.tryParse(json['PRODUIT_ID'].toString())
          : null,
      name: json['NOM']?.toString(),
      description: json['DESCR']?.toString(),
      unitPrice: json['PRIX_UNIT']?.toString(),
      weight: json['POIDS']?.toString(),
      dimensions: json['DIMENSIONS']?.toString(),
      warehouse: json['MAGASIN_ENTREPOT']?.toString(),
      barcode: json['CODE_BARRE_PRODUIT']?.toString(),
      categoryId: json['CATEGORIE_ID'] != null
          ? int.tryParse(json['CATEGORIE_ID'].toString())
          : null,
      locationId: json['EMPLACEMENT_ID'] != null
          ? int.tryParse(json['EMPLACEMENT_ID'].toString())
          : null,
      supplierId: json['FOURNISSEUR_ID'] != null
          ? int.tryParse(json['FOURNISSEUR_ID'].toString())
          : null,
      img: json['PRODUIT_IMAGE']?.toString(),
      seuil:
          json['SEUIL'] != null ? int.tryParse(json['SEUIL'].toString()) : null,
      quantity: json['QUANTITE'] != null
          ? int.tryParse(json['QUANTITE'].toString())
          : null,
      sku: json['SKU']?.toString(),
      classe: json['CLASSE']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PRODUIT_ID': productId,
      'NOM': name,
      'DESCR': description,
      'PRIX_UNIT': unitPrice,
      'POIDS': weight,
      'DIMENSIONS': dimensions,
      'MAGASIN_ENTREPOT': warehouse,
      'CODE_BARRE_PRODUIT': barcode,
      'CATEGORIE_ID': categoryId,
      'EMPLACEMENT_ID': locationId,
      'FOURNISSEUR_ID': supplierId,
      'PRODUIT_IMAGE': img,
      'SEUIL': seuil,
      'QUANTITE': quantity,
      'SKU': sku,
      'CLASSE': classe,
    };
  }

  static final empty = Product(
    productId: -1,
    name: '-',
    description: '-',
    unitPrice: '-',
    weight: '-',
    dimensions: '-',
    warehouse: '-',
    barcode: '-',
    categoryId: -1,
    locationId: -1,
    supplierId: -1,
    img: "",
    seuil: -1,
    quantity: -1,
    sku: '-',
    classe: '-',
  );
}
