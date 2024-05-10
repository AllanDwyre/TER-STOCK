import 'dart:async';

import 'package:hive_stock/utils/app/bridge_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:hive_stock/utils/methods/token_access_utils.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({required this.bridge});

  final BridgeRepository bridge;
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    final token = await AccessTokenUtils.retrieveUserToken();

    final initialStatus = token == null
        ? AuthenticationStatus.unauthenticated
        : AuthenticationStatus.authenticated;

    if (token != null) {
      bridge.getAuthentified(token);
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
    final response = await bridge.request.post('/login', data: data);

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
      "birthday": birthday,
      "phone": phone,
    };
    final response = await bridge.request.post('/register', data: data);

    if (response.statusCode == 200) {
      _getAuthentified(response.data);
    } else {
      throw Exception("${response.data}");
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    AccessTokenUtils.saveUserToken(null);
    bridge.getUnauthentified();
  }

  void dispose() => _controller.close();

  void _getAuthentified(String token) {
    AccessTokenUtils.saveUserToken(token);
    bridge.getAuthentified(token);
    _controller.add(AuthenticationStatus.authenticated);
  }
}
