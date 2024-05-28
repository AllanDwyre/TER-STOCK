class Commande {
  final int? id;
  final DateTime? dateCommande;
  final int? employeId;
  final DateTime? dateReelRecu;
  final String? prixTotal;
  final String? locationType;

  Commande({
    required this.id,
    required this.dateCommande,
    required this.employeId,
    required this.dateReelRecu,
    required this.prixTotal,
    this.locationType,
  });

  // Factory constructor to create a Commande object from a JSON map
  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['COMMANDE_ID'],
      dateCommande: DateTime.parse(json['DATE_COMMANDE']),
      employeId: json['EMPLOYE_ID'],
      dateReelRecu: DateTime.parse(json['DATE_REEL_RECU']),
      prixTotal: json['PRIX_TOTAL'],
      locationType: json['LOCATION_TYPE'],
    );
  }

  // Method to convert a Commande object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'COMMANDE_ID': id,
      'DATE_COMMANDE': dateCommande?.toIso8601String(),
      'EMPLOYE_ID': employeId,
      'DATE_REEL_RECU': dateReelRecu?.toIso8601String(),
      'PRIX_TOTAL': prixTotal,
      'LOCATION_TYPE': locationType,
    };
  }
}
