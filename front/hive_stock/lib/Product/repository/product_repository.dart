import 'dart:async';
import 'package:dio/dio.dart';
import 'package:hive_stock/product/models/movement_chart.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';

class ProductRepository {
  ProductRepository();

  Future<int> addProduct(Product product) async {
    // TODO ADD FORMDATA
    final params = FormData();

    final response =
        await BridgeController.request.post("/Products", data: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    return int.parse(response.data);
  }

  Future<Product> getProduct(int productId) async {
    final params = {"id": productId};

    final response = await BridgeController.request
        .get("/Products", queryParameters: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    final body = response.data as Map<String, dynamic>;
    return Product.fromJson(body);
  }

  Future<List<Product>> fetchProducts(
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
      return Product.fromJson(map);
    }).toList();
  }

  Future<List<MovementChart>> getMovementChart({
    required int productId,
    String period = 'Month',
  }) async {
    final params = {"productId": productId, "period": period};

    final response = await BridgeController.request
        .get("/Product/Movement", queryParameters: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    final List<dynamic> body = response.data as List;

    return body.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return MovementChart.fromJson(map);
    }).toList();
  }
}
