class UserModel {
  final String id;
  final String fullName;
  final String phone;
  final String? email;
  final bool kycVerified;
  final double balance;
  final String? imageUrl;
  final String role;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.email,
    required this.kycVerified,
    required this.balance,
    this.imageUrl,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      kycVerified: json['kycVerified'] as bool? ?? false,
      balance: (json['balance'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String?,
      role: json['role'] as String? ?? 'USER',
    );
  }
}
