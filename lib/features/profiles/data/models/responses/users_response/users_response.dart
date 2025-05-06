import 'user.dart';

class UsersResponse {
  List<User>? users;

  UsersResponse({this.users});

  factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
    users:
        (json['users'] as List<dynamic>?)
            ?.map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList(),
  );

  Map<String, dynamic> toJson() => {
    'users': users?.map((e) => e.toJson()).toList(),
  };
}
