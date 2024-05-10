import 'dart:async';
import 'package:hive_stock/user/model/user.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';

class ProductRepository {
  ProductRepository({required this.bridge});
  final BridgeRepository bridge;

  Future<User?> getProductById(int id) async {

    final response = await bridge.request.get("/homePage/getUser");

    if (response.statusCode != 200) {
      logger.e("Get user request fail ! \n=> $response", error: "Fail Request");
      return null;
    }

    return User.fromJson(response.data);
  }
}
