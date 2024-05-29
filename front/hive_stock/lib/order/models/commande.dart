class Commande {
  final int? id;
  final DateTime? dateCommande;
  final DateTime? dateDepart;
  final DateTime? dateReelRecu;
  final int? employeId;
  final String? prixTotal;
  final String? locationType;

  int get status {
    if (dateDepart == null) {
      return 0;
    }
    if (dateReelRecu == null) {
      return 1;
    }
    return 2;
  }

  Commande({
    required this.id,
    required this.dateCommande,
    required this.employeId,
    required this.dateDepart,
    required this.dateReelRecu,
    required this.prixTotal,
    required this.locationType,
  });

  // Factory constructor to create a Commande object from a JSON map
  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      id: json['COMMANDE_ID'],
      dateCommande: DateTime.tryParse(json['DATE_COMMANDE'].toString()),
      dateDepart: DateTime.tryParse(json['DATE_DEPART'].toString()),
      employeId: json['EMPLOYE_ID'],
      dateReelRecu: DateTime.tryParse(json['DATE_REEL_RECU'].toString()),
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
