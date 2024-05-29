import 'dart:async';
import 'package:hive_stock/utils/app/bridge_repository.dart';

class HomePageRepository {
  HomePageRepository();

  Future<int> fetchTotalProducts() async {
    final response =
        await BridgeController.request.get("/homePage/totalProducts");

    if (response.statusCode != 200) {
      throw Exception('Failed to load total products: ${response.statusCode}');
    }

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return data['totalProductsCount'] as int;
  }

  Future<int> fetchTotalOrders() async {
    final response =
        await BridgeController.request.get("/homePage/totalOrders");

    if (response.statusCode != 200) {
      throw Exception('Failed to load total orders: ${response.statusCode}');
    }

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return data['totalOrdersCount'] as int;
  }

  Future<int> fetchTotalSuppliers() async {
    final response =
        await BridgeController.request.get("/homePage/totalfournisseur");

    if (response.statusCode != 200) {
      throw Exception('Failed to load total suppliers: ${response.statusCode}');
    }

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return data['totalSuppliersCount'] as int;
  }

  Future<int> fetchReplenishmentLevel() async {
    final response =
        await BridgeController.request.get("/homePage/seuilProducts");

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to load replenishment level: ${response.statusCode}');
    }

    final Map<String, dynamic> data = response.data as Map<String, dynamic>;
    return data['replenishmentLevelCount'] as int;
  }
}
