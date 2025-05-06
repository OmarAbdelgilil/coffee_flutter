class RegisterRequest {
  String? userName;
  String? email;
  String? password;
  String? confirmPassword;

  RegisterRequest({
    this.userName,
    this.email,
    this.password,
    this.confirmPassword,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      confirmPassword: json['confirmPassword'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'email': email,
    'password': password,
    'confirmPassword': confirmPassword,
  };
}
