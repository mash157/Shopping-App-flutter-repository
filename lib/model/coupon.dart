class Coupon {
  final String code;
  final String description;
  final double discountPercent;
  final double? maxDiscount;
  final double minPurchase;
  final DateTime expiryDate;
  final int usageLimit;
  final int usedCount;
  final bool isActive;

  Coupon({
    required this.code,
    required this.description,
    required this.discountPercent,
    this.maxDiscount,
    required this.minPurchase,
    required this.expiryDate,
    required this.usageLimit,
    this.usedCount = 0,
    this.isActive = true,
  });

  bool canUse() {
    return isActive && 
           DateTime.now().isBefore(expiryDate) && 
           usedCount < usageLimit;
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'description': description,
    'discountPercent': discountPercent,
    'maxDiscount': maxDiscount,
    'minPurchase': minPurchase,
    'expiryDate': expiryDate.toIso8601String(),
    'usageLimit': usageLimit,
    'usedCount': usedCount,
    'isActive': isActive,
  };

  factory Coupon.fromJson(Map<String, dynamic> json) => Coupon(
    code: json['code'],
    description: json['description'],
    discountPercent: json['discountPercent'].toDouble(),
    maxDiscount: json['maxDiscount'] != null ? json['maxDiscount'].toDouble() : null,
    minPurchase: json['minPurchase'].toDouble(),
    expiryDate: DateTime.parse(json['expiryDate']),
    usageLimit: json['usageLimit'],
    usedCount: json['usedCount'] ?? 0,
    isActive: json['isActive'] ?? true,
  );
}
