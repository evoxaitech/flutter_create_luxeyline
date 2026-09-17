class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String phone;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });

  // JSON se UserModel banata hai (API se aane wala data)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // UserModel ko JSON banata hai (API ko bhejne ke liye)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    };
  }
}
