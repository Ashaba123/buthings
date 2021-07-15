class MyUser {
  String? id;
  String? email;
  String? role;
  String? phone;
  String? address;

  MyUser({this.id, this.email, this.role, this.phone, this.address});

  MyUser.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          email: json['email']! as String,
          role: json['role']! as String,
          phone: json['phone']! as String,
          address: json['address']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'phone': phone,
      'address': address,
    };
  }
}
