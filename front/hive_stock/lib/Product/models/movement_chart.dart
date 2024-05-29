class MovementChart {
  final String? period;
  final int? sales;
  final int? purchases;

  MovementChart({this.period, this.purchases, this.sales});

  factory MovementChart.fromJson(Map<String, dynamic> json) {
    return MovementChart(
      period: json['Période'].toString(),
      sales: int.tryParse(['Sales'].toString()),
      purchases: int.tryParse(['Purchases'].toString()),
    );
  }
}
