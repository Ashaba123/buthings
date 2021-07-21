class Order {
  String? id;
  String? orderNo;
  String? product;
  int? quantity;
  int? price;
  String? userEmail;
  int? total;
  String? address;
  String? phone;
  String? status;

  Order(
      {this.id,
      this.orderNo,
      this.product,
      this.userEmail,
      this.quantity,
      this.price,
      this.total,
      this.address,
      this.phone,
      this.status});

  Order.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          orderNo: json['orderNo']! as String,
          product: json['product']! as String,
          userEmail: json['user']! as String,
          quantity: json['quantity']! as int,
          price: json['price']! as int,
          total: json['total']! as int,
          address: json['address']! as String,
          phone: json['phone']! as String,
          status: json['status']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'orderNo': orderNo,
      'product': product,
      'user': userEmail,
      'quantity': quantity,
      'price': price,
      'total': total,
      'address': address,
      'phone': phone,
      'status': status,
    };
  }
}
