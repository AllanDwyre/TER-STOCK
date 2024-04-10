import 'dart:async';

import 'package:hive_stock/utils/app/frontend_bridge/frontend_bridge.dart';
import 'package:hive_stock/utils/app/frontend_bridge/request.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    // TODO : replace by the act to fecth the actual status : maybe chaching in the app.
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String email,
    required String otp,
  }) async {
    // TODO transform parameter to json file
    final response = await FrontEndBrige().post(request: RequestsName.logIn);

    if (response.statusCode == 200) {
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  Future<void> register({
    required String username,
    required String email,
    required String birthday,
    required String phone,
    required String otp,
  }) async {
    // TODO transform parameter to json file
    final response = await FrontEndBrige().post(request: RequestsName.register);

    if (response.statusCode == 200) {
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  // TODO : replace by the act to fecth the status from the backend
  // ?    : Do this function belong here or in the user repository ?
  Future<bool> userExist({
    required String username,
    required String email,
  }) async {
    // TODO transform parameter to json file
    final response =
        await FrontEndBrige().post(request: RequestsName.isUserExists);

    return response.statusCode == 200;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
