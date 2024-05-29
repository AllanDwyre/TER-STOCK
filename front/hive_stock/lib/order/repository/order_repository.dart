import 'dart:async';
import 'package:hive_stock/order/models/order.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';

class OrderRepository {
  OrderRepository();

  Future<int> addOrder() {
    throw UnimplementedError();
  }

  Future<int> getOrder(int id) {
    throw UnimplementedError();
  }

  Future<List<Order>> fetchOrders(
      {required int start, required int limit, required int type}) async {
    final typeMap = {0: "all", 1: "exit", 2: "entry"};
    final params = {"start": start, "limit": limit, "type": typeMap[type]};

    final response = await BridgeController.request
        .get("/Order/orderPagination", queryParameters: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }

    final List<dynamic> body = response.data as List;

    return body.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Order.fromJson(map);
    }).toList();
  }
}
