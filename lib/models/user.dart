class UserModel {
  final String id;
  final String email;
  final String role;
  final String? token;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    return UserModel(
      id: json['_id'] ?? json['id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      token: token ?? json['token'],
    );
  }
}
