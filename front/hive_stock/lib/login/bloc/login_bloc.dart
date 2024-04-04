import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hive_stock/login/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginOTPChanged>(_onOtpChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginUsernameSubmitted>(_onUsernameSubmitted);
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

  void _onOtpChanged(LoginOTPChanged event, Emitter<LoginState> emit) {
    final otp = Otp.dirty(event.otp);

    emit(
      state.copyWith(
        otp: otp,
        isValid: Formz.validate([otp, state.username]),
      ),
    );
  }

  // void _onPasswordChanged(
  //   LoginPasswordChanged event,
  //   Emitter<LoginState> emit,
  // ) {
  //   final password = Password.dirty(event.password);
  //   emit(
  //     state.copyWith(
  //       password: password,
  //       isValid: Formz.validate([password, state.username]),
  //     ),
  //   );
  // }
  Future<void> _onUsernameSubmitted(
    LoginUsernameSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        bool x = await _authenticationRepository.userExist(
          username: state.username.value,
        );

        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            step: x ? state.step + 1 : state.step,
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
        await _authenticationRepository.logIn(
          username: state.username.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
