part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.birthday = const Birthday.pure(),
    this.phone = const Phone.pure(),
    this.otp = const Otp.pure(),
    this.step = 0,
    this.totalStep = 2,
    this.isValid = false,
    this.isAttemptingLogin = true,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Email? email;
  final Birthday? birthday;
  final Phone? phone;
  final Otp otp;
  final int step;
  final int totalStep;
  final bool
      isAttemptingLogin; // Indicates whether the user is in the process of logging in, not registering
  final bool isValid;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Email? email,
    Birthday? birthday,
    Phone? phone,
    Otp? otp,
    bool? isValid,
    int? step,
    int? totalStep,
    bool? isAttemptingLogin,
  }) =>
      LoginState(
        status: status ?? this.status,
        step: step ?? this.step,
        username: username ?? this.username,
        otp: otp ?? this.otp,
        isValid: isValid ?? this.isValid,
        totalStep: totalStep ?? this.totalStep,
        isAttemptingLogin: isAttemptingLogin ?? this.isAttemptingLogin,
      );

  @override
  List<Object> get props =>
      [status, isAttemptingLogin, username, otp, step, totalStep];
}
