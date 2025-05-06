class DeleteUserResponse {
  String? message;

  DeleteUserResponse({this.message});

  factory DeleteUserResponse.fromJson(Map<String, dynamic> json) {
    return DeleteUserResponse(message: json['message'] as String?);
  }

  Map<String, dynamic> toJson() => {'message': message};
}
