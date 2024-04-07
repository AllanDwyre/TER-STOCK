import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    // TODO : replace by the act to fecth the actual status : maybe chaching in the app.
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  // TODO : Implement the register function ?

  // TODO : replace by the act to fecth the status from the backend, maybe otp ?
  Future<void> logIn({
    required String username,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  // TODO : replace by the act to fecth the status from the backend
  // ?    : Do this function belong here or in the user repository ?
  Future<bool> userExist({
    required String username,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
    );
    return true;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}