class LoginRequest {
  String? userName;
  String? password;

  LoginRequest({this.userName, this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    userName: json['userName'] as String?,
    password: json['password'] as String?,
  );

  Map<String, dynamic> toJson() => {'userName': userName, 'password': password};
}
