import 'package:flutter/material.dart';
import '../model/user.dart';
import '../model/order.dart';
import '../model/coupon.dart';

class AuthProvider extends ChangeNotifier {
  User? _currentUser;
  List<User> _registeredUsers = [];
  List<Order> _orders = [];
  List<Coupon> _coupons = [
    Coupon(
      code: 'SAVE10',
      description: '10% off on all purchases',
      discountPercent: 10,
      maxDiscount: 100,
      minPurchase: 100,
      expiryDate: DateTime.now().add(Duration(days: 30)),
      usageLimit: 100,
    ),
    Coupon(
      code: 'SAVE20',
      description: '20% off on purchases over \$500',
      discountPercent: 20,
      maxDiscount: 150,
      minPurchase: 500,
      expiryDate: DateTime.now().add(Duration(days: 30)),
      usageLimit: 50,
    ),
    Coupon(
      code: 'WELCOME',
      description: '15% off for new users',
      discountPercent: 15,
      maxDiscount: 75,
      minPurchase: 200,
      expiryDate: DateTime.now().add(Duration(days: 60)),
      usageLimit: 200,
    ),
    Coupon(
      code: 'FLASH50',
      description: 'Flat \$50 off on orders over \$300',
      discountPercent: 0,
      maxDiscount: 50,
      minPurchase: 300,
      expiryDate: DateTime.now().add(Duration(days: 7)),
      usageLimit: 30,
    ),
  ];

  AuthProvider() {
    // Initialize with demo user
    _registeredUsers.add(
      User(
        id: 'demo_user_001',
        email: 'demo@example.com',
        password: '123456',
        name: 'Demo User',
        phone: '9876543210',
        addresses: [
          '123 Main Street\nApartment 4B\nNew York, NY 10001',
          '456 Oak Avenue\nSuite 200\nLos Angeles, CA 90001',
          '789 Pine Road\nNew San Francisco, CA 94102',
        ],
      ),
    );
  }

  User? get currentUser => _currentUser;
  List<Order> get orders => _orders.where((o) => o.userId == _currentUser?.id).toList();
  List<User> get users => _registeredUsers;

  // Signup
  bool signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    // Check if email already exists
    if (_registeredUsers.any((u) => u.email == email)) {
      return false; // Email already exists
    }

    final newUser = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      password: password,
      name: name,
      phone: phone,
      addresses: ['123 Main Street\nApartment 4B\nNew York, NY 10001'],
    );

    _registeredUsers.add(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  // Login
  bool login({
    required String email,
    required String password,
  }) {
    final user = _registeredUsers.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => User(
        id: '',
        email: '',
        password: '',
        name: '',
        phone: '',
        addresses: [],
      ),
    );

    if (user.id.isEmpty) {
      return false; // Login failed
    }

    _currentUser = user;
    notifyListeners();
    return true;
  }

  // Logout
  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  // Add order
  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  // Get current user's orders
  List<Order> getUserOrders() {
    if (_currentUser == null) return [];
    return _orders.where((o) => o.userId == _currentUser!.id).toList();
  }

  // Get coupon by code
  Coupon? getCoupon(String code) {
    try {
      return _coupons.firstWhere((c) => c.code == code.toUpperCase());
    } catch (e) {
      return null;
    }
  }

  // Get all valid coupons
  List<Coupon> getValidCoupons() {
    return _coupons.where((c) => c.canUse()).toList();
  }

  // Use coupon
  bool useCoupon(String code) {
    final coupon = getCoupon(code);
    if (coupon != null && coupon.canUse()) {
      int index = _coupons.indexWhere((c) => c.code == code.toUpperCase());
      _coupons[index] = Coupon(
        code: coupon.code,
        description: coupon.description,
        discountPercent: coupon.discountPercent,
        maxDiscount: coupon.maxDiscount,
        minPurchase: coupon.minPurchase,
        expiryDate: coupon.expiryDate,
        usageLimit: coupon.usageLimit,
        usedCount: coupon.usedCount + 1,
        isActive: coupon.isActive,
      );
      return true;
    }
    return false;
  }

  // Update user profile
  void updateUserProfile({
    required String name,
    required String phone,
    required List<String> addresses,
  }) {
    if (_currentUser != null) {
      _currentUser = User(
        id: _currentUser!.id,
        email: _currentUser!.email,
        password: _currentUser!.password,
        name: name,
        phone: phone,
        addresses: addresses,
        defaultAddress: _currentUser!.defaultAddress,
      );
      notifyListeners();
    }
  }

  // Update a specific address
  void updateUserAddress(int index, String newAddress) {
    if (_currentUser != null && index >= 0 && index < _currentUser!.addresses.length) {
      final updatedAddresses = [..._currentUser!.addresses];
      updatedAddresses[index] = newAddress;
      _currentUser = User(
        id: _currentUser!.id,
        email: _currentUser!.email,
        password: _currentUser!.password,
        name: _currentUser!.name,
        phone: _currentUser!.phone,
        addresses: updatedAddresses,
        defaultAddress: _currentUser!.defaultAddress,
      );
      notifyListeners();
    }
  }
}
