import 'dart:async';
import 'package:hive_stock/product/models/inventory_stats.dart';
import 'package:hive_stock/product/models/movement_chart.dart';
import 'package:hive_stock/product/models/product.dart';
import 'package:hive_stock/product/models/product_form.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';

class ProductRepository {
  ProductRepository();

  Future<int> addProduct(ProductAddForm product) async {
    logger.d(product.toJson());

    final response = await BridgeController.request
        .post("/Products", data: product.toJson());

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

  Future<InventoryStats> getStatsInventory() async {
    final totalResponse =
        await BridgeController.request.get("/Inventory/TotalProductsCount");

    if (totalResponse.statusCode != 200) {
      throw Exception(totalResponse);
    }

    final categories =
        await BridgeController.request.get("/Inventory/TotalCategories");

    if (categories.statusCode != 200) {
      throw Exception(categories);
    }

    final selling = await BridgeController.request.get("/Inventory/topSelling");

    if (selling.statusCode != 200) {
      throw Exception(selling);
    }

    final lowstock =
        await BridgeController.request.get("/Inventory/LowStockProductsCount");

    if (lowstock.statusCode != 200) {
      throw Exception(selling);
    }

    Map<String, dynamic> data = totalResponse.data as Map<String, dynamic>;
    int? totalProduct = int.tryParse(data["totalProductsCount"].toString());

    data = categories.data as Map<String, dynamic>;
    int? totalCategory = int.tryParse(data["TotalCategoriesCount"].toString());

    data = selling.data as Map<String, dynamic>;
    String? topSelling = data["NOM"] as String;

    data = lowstock.data as Map<String, dynamic>;
    int? lowstockCount = int.tryParse(data["result"].toString());

    return InventoryStats(
      lowStocks: lowstockCount,
      topSelling: topSelling,
      totalCategories: totalCategory,
      totalProducts: totalProduct,
    );
  }
}
