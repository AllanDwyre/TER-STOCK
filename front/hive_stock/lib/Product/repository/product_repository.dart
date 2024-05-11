import 'dart:async';
import 'package:hive_stock/product/models/product_inventory.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';

class ProductRepository {
  ProductRepository({required this.bridge});
  final BridgeRepository bridge;

  Future<List<ProductInventory>> fetchProducts(
      {int start = 0, required int limit}) async {
    final params = {"start": start, "limit": limit};

    final response = await bridge.request
        .get("/Inventory/fetchPagination", queryParameters: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    final List<dynamic> body = response.data as List;

    return body.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return ProductInventory.fromJson(map);
    }).toList();
  }
}
