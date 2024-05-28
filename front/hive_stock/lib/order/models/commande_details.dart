class CommandeDetails {
  final String? nameProduct;
  final int? quantity;
  final int? productId;
  final int? commandeId;

  CommandeDetails({
    this.nameProduct,
    this.quantity,
    this.productId,
    this.commandeId,
  });

  factory CommandeDetails.fromJson(Map<String, dynamic> json) {
    return CommandeDetails(
      nameProduct: json['NOM'],
      quantity: json['LIGNE_COMMANDE']?['QUANTITE'],
      productId: json['LIGNE_COMMANDE']?['PRODUIT_ID'],
      commandeId: json['LIGNE_COMMANDE']?['COMMANDE_ID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NOM': nameProduct,
      'LIGNE_COMMANDE': {
        'QUANTITE': quantity,
        'PRODUIT_ID': productId,
        'COMMANDE_ID': commandeId,
      },
    };
  }
}
