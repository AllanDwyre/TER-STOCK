import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/product/models/product_inventory.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';

class ProductRepository {
  ProductRepository();

  Future<int> addProduct(Product product) async {
    // TODO ADD FORMDATA
    final params = FormData();

    final response = await BridgeController.request
        .post("/Products", data: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    return int.parse(response.data);
  }

  Future<ProductInventory> getProduct(int productId) async {
    final params = {"id": productId};

    final response =
        await BridgeController.request.get("/Products", queryParameters: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    final body = response.data as Map<String, dynamic>;
    return ProductInventory.fromJson(body);
  }

  Future<List<ProductInventory>> fetchProducts(
      {int start = 0, required int limit}) async {
    final params = {"start": start, "limit": limit};

    final response = await BridgeController.request
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
