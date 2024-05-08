import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_stock/utils/app/bridge_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  AuthenticationRepository({required this.bridge});

  final BridgeRepository bridge;
  final _controller = StreamController<AuthenticationStatus>();

  // TODO : replace by the act to fecth the actual status : maybe caching in the app.
  Stream<AuthenticationStatus> get status async* {
    // data persistence
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
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
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      throw Exception("Failed Login");
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
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
