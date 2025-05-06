class DeleteUserRequest {
  String? userId;

  DeleteUserRequest({this.userId});

  factory DeleteUserRequest.fromJson(Map<String, dynamic> json) {
    return DeleteUserRequest(userId: json['userId'] as String?);
  }

  Map<String, dynamic> toJson() => {'userId': userId};
}
