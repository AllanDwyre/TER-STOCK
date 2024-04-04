part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class LoginOTPChanged extends LoginEvent {
  const LoginOTPChanged(this.otp);

  final String otp;

  @override
  List<Object> get props => [otp];
}
// TODO : Implements others fields to log in.

final class LoginUsernameSubmitted extends LoginEvent {
  const LoginUsernameSubmitted();
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
