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

final class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

final class LoginBirthdayChanged extends LoginEvent {
  const LoginBirthdayChanged(this.birthday);

  final String birthday;

  @override
  List<Object> get props => [birthday];
}

final class LoginPhoneChanged extends LoginEvent {
  const LoginPhoneChanged(this.phone);

  final String phone;

  @override
  List<Object> get props => [phone];
}

final class LoginSwitch extends LoginEvent {
  const LoginSwitch();
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}
