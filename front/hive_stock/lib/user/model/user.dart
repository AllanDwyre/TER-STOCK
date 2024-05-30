class User {
  const User(
      {required this.id,
      required this.username,
      required this.firstname,
      required this.email,
      required this.lastname,
      required this.phoneNumber,
      required this.birthday});

  final String? id;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phoneNumber;
  final DateTime? birthday;

  String get fullname => '$firstname $lastname';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['USER_ID'].toString(),
      username: json['USERNAME'].toString(),
      firstname: json['FIRSTNAME'].toString(),
      lastname: json['LASTNAME'].toString(),
      email: json['USER_MAIL'].toString(),
      phoneNumber: json['USER_TEL'],
      birthday: DateTime.tryParse(json['USER_DATE_NAISS'].toString()),
    );
  }

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
