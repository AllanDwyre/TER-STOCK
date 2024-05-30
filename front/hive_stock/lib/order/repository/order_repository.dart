import 'dart:async';
import 'package:hive_stock/order/models/order.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';

import '../models/orders_stats.dart';

class OrderRepository {
  OrderRepository();

  Future<int> addOrder() {
    throw UnimplementedError();
  }

  Future<Order?> getOrder(int id) async {
    final params = {"id": id};
    final response =
        await BridgeController.request.get("/Order", queryParameters: params);

    if (response.statusCode != 200) {
      throw Exception(response);
    }
    return Order.fromJson(response.data);
  }

  Future<List<Order>> fetchOrders(
      {required int start, required int limit, required int type}) async {
    final typeMap = {0: "all", 1: "entry", 2: "exit"};
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

  Future<OrdersStats> getStatsOrders() async {
    final totalResponse =
        await BridgeController.request.get("/Order/TotalOrdersCount");

    if (totalResponse.statusCode != 200) {
      throw Exception(totalResponse);
    }

    final received =
        await BridgeController.request.get("/Order/TotalOrdersreceived");

    if (received.statusCode != 200) {
      throw Exception(received);
    }

    final returned =
        await BridgeController.request.get("/Order/TotalOrdersreturned");

    if (returned.statusCode != 200) {
      throw Exception(returned);
    }

    final client =
        await BridgeController.request.get("/Order/TotalOrdersInTransitClient");

    if (client.statusCode != 200) {
      throw Exception(returned);
    }

    final fourn = await BridgeController.request
        .get("/Order/TotalOrdersInTransitFournisseur");

    if (fourn.statusCode != 200) {
      throw Exception(returned);
    }
    Map<String, dynamic> data = totalResponse.data as Map<String, dynamic>;
    int? totalOrder = int.tryParse(data["totalOrdersCount"].toString());

    data = received.data as Map<String, dynamic>;
    int? totalReceived =
        int.tryParse(data["getTotalOrdersReceived"].toString());

    data = returned.data as Map<String, dynamic>;
    int? totaltReturned = int.tryParse(data["returnOrdersCount"].toString());

    int? totalClient = int.tryParse(client.data.toString());
    int? totalFournisseur = int.tryParse(fourn.data.toString());

    return OrdersStats(
        totalClient: totalClient,
        totaltReturned: totaltReturned,
        totalReceived: totalReceived,
        totalOrder: totalOrder,
        totalFournisseur: totalFournisseur);
  }
}
