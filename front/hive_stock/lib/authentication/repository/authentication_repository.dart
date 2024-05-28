import 'dart:async';

import 'package:hive_stock/utils/app/bridge_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:hive_stock/utils/methods/token_access_utils.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository();

  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    final token = await AccessTokenUtils.retrieveUserToken();

    final initialStatus = token == null
        ? AuthenticationStatus.unauthenticated
        : AuthenticationStatus.authenticated;

    if (token != null) {
      BridgeController.getAuthentified(token);
    }

    logger.t("Initial user state : $initialStatus");

    yield initialStatus;

    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    Map<String, Object?> data = {
      "username": username,
      "password": password,
    };
    final response = await BridgeController.request.post('/login', data: data);

    if (response.statusCode == 200) {
      _getAuthentified(response.data);
    } else {
      throw Exception("Couldn't find your HiveStock account");
    }
  }

  Future<void> register({
    required String username,
    required String password,
    required String email,
    required String birthday,
    required String phone,
    // required String otp,
  }) async {
    Map<String, Object?> data = {
      "username": username,
      "password": password,
      "email": email,
      "user_date": birthday,
      "user_tel": phone
    };
    final response =
        await BridgeController.request.post('/register', data: data);

    if (response.statusCode == 200) {
      _getAuthentified(response.data);
    } else {
      throw Exception("${response.data}");
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    AccessTokenUtils.saveUserToken(null);
    BridgeController.getUnauthentified();
  }

  void dispose() => _controller.close();

  void _getAuthentified(String token) {
    AccessTokenUtils.saveUserToken(token);
    BridgeController.getAuthentified(token);
    _controller.add(AuthenticationStatus.authenticated);
  }
}
