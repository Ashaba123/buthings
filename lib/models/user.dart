class MyUser {
  String? id;
  String? name;
  String? email;
  String? role;
  String? phone;
  String? address;

  MyUser({this.id, this.name, this.email, this.role, this.phone, this.address});

  MyUser.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          email: json['email']! as String,
          role: json['role']! as String,
          phone: json['phone']! as String,
          address: json['address']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'address': address,
    };
  }
}
