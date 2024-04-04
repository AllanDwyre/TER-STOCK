part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.otp = const Otp.pure(),
    this.step = 0,
    //todo : Implements others fields
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Otp otp;
  final int step;
  //todo : Implements others fields

  final bool isValid;

  LoginState copyWith(
          {FormzSubmissionStatus? status,
          Username? username,
          Otp? otp,
          bool? isValid,
          int? step}) =>
      LoginState(
        status: status ?? this.status,
        step: step ?? this.step,
        username: username ?? this.username,
        otp: otp ?? this.otp,
        isValid: isValid ?? this.isValid,
      );

  @override
  List<Object> get props => [status, username, otp, step];
}
