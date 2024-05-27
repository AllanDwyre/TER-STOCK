import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_stock/user/model/user.dart';
import 'package:hive_stock/user/repository/user_repository.dart';
import 'package:hive_stock/utils/methods/logger.dart';
import 'package:logger/logger.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(const UserState()) {
    on<OnUserFetched>(onUserFetched);
  }
  final UserRepository _userRepository;

  FutureOr<void> onUserFetched(event, emit) async {
    final user = await _tryGetUser();
    if (user != null) {
      emit(
        state.copyWith(user: user),
      );
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      logger.log(user == null ? Level.error : Level.trace,
          'TryGetUser - current user value : $user');

      return user;
    } on Exception catch (e) {
      logger.e("Can't get user user : $e", error: 'Trace Error');
      return null;
    }
  }
}
