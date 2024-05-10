import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  const User(
      {required this.id,
      required this.username,
      required this.firstname,
      required this.email,
      required this.lastname,
      required this.phoneNumber,
      required this.birthday});

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String firstname;
  @HiveField(3)
  final String lastname;
  @HiveField(4)
  final String email;
  @HiveField(5)
  final String phoneNumber;
  @HiveField(6)
  final DateTime? birthday;

  String get fullname => '$firstname $lastname';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['userid'].toString(),
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['usermail'],
      phoneNumber: json['usertel'],
      birthday: DateTime.parse(json['userdate']),
    );
  }

  @override
  List<Object> get props => [id];

  static const empty = User(
    id: '-',
    username: '-',
    firstname: '-',
    lastname: '-',
    phoneNumber: '-',
    email: '-',
    birthday: null,
  );
}
