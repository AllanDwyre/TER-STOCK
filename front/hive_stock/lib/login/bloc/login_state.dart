part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    //todo : Implements others fields
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Username username;
  //todo : Implements others fields

  final bool isValid;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    //todo : Implements others fields

    bool? isValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [status, username]; //todo : Implements others fields
}
