class Product {
  final String id;
  final String title;
  final String price;
  final String image;
  final String description;
  final String category;
  final double rating;
  final int reviewCount;
  bool isAdded = false;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    this.rating = 0.0,
    this.reviewCount = 0,
  });
}
