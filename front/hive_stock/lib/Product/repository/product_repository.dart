import 'dart:async';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/product/models/product_inventory.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';

class ProductRepository {
  ProductRepository({required BridgeRepository bridge}) : _bridge = bridge;
  final BridgeRepository _bridge;

  Future<ProductInventory> addProduct(Product product) async {
    final params = product.toJson();

    final response =
        await _bridge.request.post("/Product", queryParameters: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    final body = response.data as Map<String, dynamic>;
    return ProductInventory.fromJson(body);
  }

  Future<ProductInventory> getProduct(int productId) async {
    final params = {"id": productId};

    final response =
        await _bridge.request.get("/Product", queryParameters: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    final body = response.data as Map<String, dynamic>;
    return ProductInventory.fromJson(body);
  }

  Future<List<ProductInventory>> fetchProducts(
      {int start = 0, required int limit}) async {
    final params = {"start": start, "limit": limit};

    final response = await _bridge.request
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
