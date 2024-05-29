class ScanResponse {
  final String? type;
  final int? id;
  final String? expectedLocation;
  final List<ScanResponseDetails>? details;

  ScanResponse(
      {required this.type,
      required this.id,
      required this.expectedLocation,
      required this.details});

  factory ScanResponse.fromJson(Map<String, dynamic> json) {
    List<ScanResponseDetails> scanResponseDetailsList =
        (json["products"] as List).map((detailsJson) {
      return ScanResponseDetails.fromJson(detailsJson);
    }).toList();
    return ScanResponse(
      type: json['scanType'] as String,
      id: json['id'] as int,
      expectedLocation: json['exected_location'] as String,
      details: scanResponseDetailsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scanType': type,
      'id': id,
    };
  }
}

class ScanResponseDetails {
  String? productName;
  int? quantity;

  ScanResponseDetails({required this.productName, required this.quantity});

  factory ScanResponseDetails.fromJson(Map<String, dynamic> json) {
    return ScanResponseDetails(
      productName: json['product'] as String,
      quantity: json['quantity'] as int,
    );
  }
}
