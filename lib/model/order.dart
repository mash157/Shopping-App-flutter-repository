class Order {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final double subtotal;
  final double tax;
  final double shipping;
  final double total;
  final String paymentMethod;
  final String deliveryAddress;
  final String status; // pending, processing, shipped, delivered
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final String? appliedCoupon;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.subtotal,
    required this.tax,
    required this.shipping,
    required this.total,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.status,
    required this.orderDate,
    this.deliveryDate,
    this.appliedCoupon,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'items': items.map((item) => item.toJson()).toList(),
    'subtotal': subtotal,
    'tax': tax,
    'shipping': shipping,
    'total': total,
    'paymentMethod': paymentMethod,
    'deliveryAddress': deliveryAddress,
    'status': status,
    'orderDate': orderDate.toIso8601String(),
    'deliveryDate': deliveryDate?.toIso8601String(),
    'appliedCoupon': appliedCoupon,
  };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json['id'],
    userId: json['userId'],
    items: (json['items'] as List).map((item) => OrderItem.fromJson(item)).toList(),
    subtotal: json['subtotal'].toDouble(),
    tax: json['tax'].toDouble(),
    shipping: json['shipping'].toDouble(),
    total: json['total'].toDouble(),
    paymentMethod: json['paymentMethod'],
    deliveryAddress: json['deliveryAddress'],
    status: json['status'],
    orderDate: DateTime.parse(json['orderDate']),
    deliveryDate: json['deliveryDate'] != null ? DateTime.parse(json['deliveryDate']) : null,
    appliedCoupon: json['appliedCoupon'],
  );
}

class OrderItem {
  final String productId;
  final String title;
  final String price;
  final int quantity;
  final double itemTotal;

  OrderItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.itemTotal,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'title': title,
    'price': price,
    'quantity': quantity,
    'itemTotal': itemTotal,
  };

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    productId: json['productId'],
    title: json['title'],
    price: json['price'],
    quantity: json['quantity'],
    itemTotal: json['itemTotal'].toDouble(),
  );
}
