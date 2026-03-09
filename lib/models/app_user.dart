class AppUser {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String avatarUrl;

  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json["id"]?.toString() ?? "",
      fullName: json["fullName"]?.toString() ?? "",
      email: json["email"]?.toString() ?? "",
      phone: json["phone"]?.toString() ?? "",
      avatarUrl: json["avatarUrl"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "avatarUrl": avatarUrl,
    };
  }

  AppUser copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
  }) {
    return AppUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}
