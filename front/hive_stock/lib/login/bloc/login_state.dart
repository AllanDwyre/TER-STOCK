part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.birthday = const Birthday.pure(),
    this.phone = const Phone.pure(),
    this.otp = const Otp.pure(),
    this.isValid = false,
    this.isAttemptingLogin,
  });

  final Username username;
  final Email email;
  final Birthday birthday;
  final Phone phone;
  final Otp otp;

  /// Indicates whether the form is correctly fill or not
  final bool isValid;

  /// Indicates the result of the submission
  final FormzSubmissionStatus status;

  /// Indicates whether the user is in the process of logging in, not registering
  final bool? isAttemptingLogin;

  LoginState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Email? email,
    Birthday? birthday,
    Phone? phone,
    Otp? otp,
    bool? isValid,
    bool? isAttemptingLogin,
  }) =>
      LoginState(
        status: status ?? this.status,
        username: username ?? this.username,
        email: email ?? this.email,
        birthday: birthday ?? this.birthday,
        phone: phone ?? this.phone,
        otp: otp ?? this.otp,
        isValid: isValid ?? this.isValid,
        isAttemptingLogin: isAttemptingLogin ?? this.isAttemptingLogin,
      );

  @override
  List<Object> get props => [status, username, email, birthday, phone, otp];
}
