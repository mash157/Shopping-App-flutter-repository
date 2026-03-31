class Review {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final double rating; // 1-5
  final String reviewText;
  final DateTime reviewDate;
  final int helpfulCount;

  Review({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.rating,
    required this.reviewText,
    required this.reviewDate,
    this.helpfulCount = 0,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'productId': productId,
    'userId': userId,
    'userName': userName,
    'rating': rating,
    'reviewText': reviewText,
    'reviewDate': reviewDate.toIso8601String(),
    'helpfulCount': helpfulCount,
  };

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json['id'],
    productId: json['productId'],
    userId: json['userId'],
    userName: json['userName'],
    rating: json['rating'].toDouble(),
    reviewText: json['reviewText'],
    reviewDate: DateTime.parse(json['reviewDate']),
    helpfulCount: json['helpfulCount'] ?? 0,
  );
}
