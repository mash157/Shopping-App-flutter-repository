class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final String phone;
  final List<String> addresses;
  final String defaultAddress;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    required this.addresses,
    this.defaultAddress = '',
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'password': password,
    'name': name,
    'phone': phone,
    'addresses': addresses,
    'defaultAddress': defaultAddress,
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    email: json['email'],
    password: json['password'],
    name: json['name'],
    phone: json['phone'],
    addresses: List<String>.from(json['addresses'] ?? []),
    defaultAddress: json['defaultAddress'] ?? '',
  );
}
