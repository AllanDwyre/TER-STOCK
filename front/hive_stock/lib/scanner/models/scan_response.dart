class ScanResponse {
  final String type;
  final int id;

  ScanResponse({required this.type, required this.id});

  factory ScanResponse.fromJson(Map<String, dynamic> json) {
    return ScanResponse(
      type: json['type'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
    };
  }
}
