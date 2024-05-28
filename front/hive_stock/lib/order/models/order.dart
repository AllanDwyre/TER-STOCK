import 'package:hive_stock/order/models/commande.dart';
import 'package:hive_stock/order/models/commande_details.dart';

class Order {
  final int? id;
  final Commande? commande;
  final List<CommandeDetails>? details;
  final int? exitId;
  final int? entryId;

  bool get isEntry => entryId != null && exitId == null;
  bool get isExit => entryId == null && exitId != null;

  Order({this.id, this.commande, this.details, this.exitId, this.entryId});

  factory Order.fromJson(Map<String, dynamic> json) {
    List<CommandeDetails> commandeDetailsList =
        (json["PRODUIT_ID_produits"] as List).map((productJson) {
      return CommandeDetails.fromJson(productJson);
    }).toList();

    return Order(
      id: json["COMMANDE_ID"],
      commande: Commande.fromJson(json),
      details: commandeDetailsList,
      entryId: json["commande_fournisseur"]?["FOURNISSEUR_ID"],
      exitId: json["commande_client"]?["CLIENT_ID"],
    );
  }
}
