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
      productId: json['PRODUIT_ID'],
      name: json['NOM'],
      description: json['DESCR'],
      unitPrice: json['PRIX_UNIT'],
      weight: json['POIDS'],
      dimensions: json['DIMENSIONS'],
      warehouse: json['MAGASIN_ENTREPOT'],
      barcode: json['CODE_BARRE_PRODUIT'],
      categoryId: json['CATEGORIE_ID'],
      locationId: json['EMPLACEMENT_ID'],
      supplierId: json['FOURNISSEUR_ID'],
      img: json['PRODUIT_IMAGE'],
      seuil: json['SEUIL'],
      quantity: json['QUANTITE'],
      sku: json['SKU'],
      classe: json['CLASSE'],
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
