class User {
  int? id;
  String? email;
  String? password;
  String? role;
  String? phone;
  String? address;

  User(
      {this.id,
      this.email,
      this.password,
      this.role,
      this.phone,
      this.address});

  User.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as int,
          email: json['email']! as String,
          password: json['password']! as String,
          role: json['role']! as String,
          phone: json['phone']! as String,
          address: json['address']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'role': role,
      'phone': phone,
      'address': address,
    };
  }
}
