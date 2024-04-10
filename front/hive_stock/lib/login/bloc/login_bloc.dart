import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/login/models/models.dart';
import 'package:hive_stock/utils/app/authentication_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginBirthdayChanged>(_onBirthdayChanged);
    on<LoginPhoneChanged>(_onPhoneChanged);
    on<LoginOTPChanged>(_onOtpChanged);
    on<LoginReset>(_onReset);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginAttemptSubmitted>(_onAttemptSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
      LoginUsernameChanged event, Emitter<LoginState> emit) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([username]),
      ),
    );
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([state.username, email]),
      ),
    );
  }

  void _onBirthdayChanged(
      LoginBirthdayChanged event, Emitter<LoginState> emit) {
    final birthday = Birthday.dirty(event.birthday);
    emit(
      state.copyWith(
        birthday: birthday,
        isValid: Formz.validate([birthday]),
      ),
    );
  }

  void _onPhoneChanged(LoginPhoneChanged event, Emitter<LoginState> emit) {
    final phone = Phone.dirty(event.phone);
    emit(
      state.copyWith(
        phone: phone,
        isValid: Formz.validate([phone]),
      ),
    );
  }

  void _onOtpChanged(LoginOTPChanged event, Emitter<LoginState> emit) {
    final otp = Otp.dirty(event.otp);

    emit(
      state.copyWith(
        otp: otp,
        isValid: Formz.validate([otp, state.username]),
      ),
    );
  }

  FutureOr<void> _onReset(LoginReset event, Emitter<LoginState> emit) {
    emit(state.copyWith(isValid: false, status: FormzSubmissionStatus.initial));
  }

  Future<void> _onAttemptSubmitted(
    LoginAttemptSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        bool isUserExit = await _authenticationRepository.userExist(
          username: state.username.value,
          email: state.email.value,
        );

        emit(
          state.copyWith(
            isAttemptingLogin: isUserExit,
            status: FormzSubmissionStatus.success,
          ),
        );
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        if (state.isAttemptingLogin == null) {
          throw AssertionError('isAttemptingLogin can not be null!');
        }
        if (state.isAttemptingLogin!) {
          await _authenticationRepository.logIn(
            username: state.username.value,
            email: state.email.value,
            otp: state.otp.value,
          );
        } else {
          await _authenticationRepository.register(
            username: state.username.value,
            email: state.email.value,
            birthday: state.birthday.value,
            phone: state.phone.value,
            otp: state.otp.value,
          );
        }
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
