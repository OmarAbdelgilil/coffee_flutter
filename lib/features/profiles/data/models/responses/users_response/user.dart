class User {
  String? id;
  String? userName;
  String? email;
  String? role;
  int? v;
  String? firstName;
  String? lastName;

  User({
    this.id,
    this.userName,
    this.email,
    this.role,
    this.v,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['_id'] as String?,
    userName: json['userName'] as String?,
    email: json['email'] as String?,
    role: json['role'] as String?,
    v: json['__v'] as int?,
    firstName: json['firstName'] as String?,
    lastName: json['lastName'] as String?,
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'userName': userName,
    'email': email,
    'role': role,
    '__v': v,
    'firstName': firstName,
    'lastName': lastName,
  };
}
