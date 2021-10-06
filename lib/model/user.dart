import 'package:rtlfreq/component/utils.dart';

final String tableUser = 'user';

class UserFields {
  static final String id = '_id';
  static final String login = 'login';
  static final String password = 'password';
  static final String dateTime = 'dateTime';
  static final String firstLogin = 'firstLogin';
  static final String synchronized = 'synchronized';
  static final String synchronizedDateTime = 'synchronizedDateTime';

  static final List<String> values = [
    id, login, password, dateTime, firstLogin, synchronized, synchronizedDateTime
  ];
}
class User {
  final int? id;
  final String login;
  final String password;
  final String dateTime;
  final int? firstLogin;
  final int? synchronized;
  final String? synchronizedDateTime;

  const User ({
    this.id,
    required this.login,
    required this.password,
    required this.dateTime,
    this.firstLogin,
    this.synchronized,
    this.synchronizedDateTime
  });

  factory User.fromMap(Map<String, Object?> json) => User (
    id: json['id'] != null ? (json['id'] as int) : null,
    login: json['login'] as String,
    password: json['password'] as String,
    dateTime: json['dateTime'] as String,
    firstLogin: (json['firstLogin'] ?? 1) as int,
    synchronized: (json['synchronized'] ?? 0) as int,
    synchronizedDateTime: (json['synchronizedDateTime'] ?? "") as String
  );

  Map<String, Object?> toJson() {
    return {
      "id": id,
      "login": login,
      "password": password,
      "dateTime": dateTime,
      "firstLogin": firstLogin,
      "synchronized": synchronized,
      "synchronizedDateTime": synchronizedDateTime
    };
  }

  User copy({
    int? id,
    String? login,
    String? password,
    String? dateTime,
    int? firstLogin,
    int? synchronized,
    String? synchronizedDateTime
}) => User (
      id: id ?? this.id,
      login: login ?? this.login,
      password: password ?? this.password,
      dateTime: dateTime ?? this.dateTime,
      firstLogin: firstLogin ?? this.firstLogin,
      synchronized: synchronized ?? this.synchronized,
      synchronizedDateTime: synchronizedDateTime ?? this.synchronizedDateTime
  );
}
