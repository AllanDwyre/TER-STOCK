part of 'user_bloc.dart';

final class UserState extends Equatable {
  final User? user;

  const UserState({this.user});

  copyWith({User? user}) => UserState(user: user ?? this.user);

  @override
  List<Object?> get props => [user];
}
