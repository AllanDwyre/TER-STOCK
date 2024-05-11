import 'package:hive_stock/product/models/product.dart';

class ProductInventory {
  final Product product;
  final int inventaireId;
  final int staffId;
  final int quantity;
  final DateTime inventoryDate;

  ProductInventory({
    required this.product,
    required this.inventaireId,
    required this.staffId,
    required this.quantity,
    required this.inventoryDate,
  });

  factory ProductInventory.fromJson(Map<String, dynamic> json) {
    return ProductInventory(
      product: Product.fromJson(json),
      inventaireId: json['inventaire_produits'][0]['INVENTAIRE_ID'] as int,
      staffId: json['inventaire_produits'][0]['EMPLOYE_ID'] as int,
      quantity: json['inventaire_produits'][0]['QUANTITE_OBSERVEE'] as int,
      inventoryDate:
          DateTime.parse(json['inventaire_produits'][0]['DATE_INV'] as String),
    );
  }
}
