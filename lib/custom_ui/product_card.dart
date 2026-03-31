import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../providers/currency_provider.dart';
import '../screens/product_details_screen.dart';
import 'product_image_widget.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
      },
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 0.95).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: Card(
          color: Theme.of(context).brightness == Brightness.dark
              ? (widget.product.isAdded ? Colors.green.shade900 : Colors.grey.shade900)
              : (widget.product.isAdded ? Colors.green.shade50 : Colors.white),
          elevation: widget.product.isAdded ? 12 : 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: Theme.of(context).brightness == Brightness.dark
                  ? (widget.product.isAdded
                      ? Colors.green.shade600
                      : Colors.grey.shade700)
                  : (widget.product.isAdded
                      ? Colors.green.shade300
                      : Colors.grey.shade200),
              width: 2,
            ),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: widget.product.isAdded
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: Theme.of(context).brightness == Brightness.dark
                          ? [
                              Colors.green.shade900,
                              Colors.green.shade800,
                            ]
                          : [
                              Colors.green.shade50,
                              Colors.white,
                            ],
                    )
                  : null,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.015,
              ),
              child: Row(
                children: [
                  // Product Image
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductDetailsScreen(
                            product: widget.product,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.22,
                        height: MediaQuery.of(context).size.width * 0.22,
                        color: Colors.grey.shade100,
                        child: Image.asset(
                          'assets/images/${widget.product.image}',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return ProductImageWidget(
                              productTitle: widget.product.title,
                              imageUrl: widget.product.image,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Product Info
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ProductDetailsScreen(
                              product: widget.product,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.product.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: widget.product.isAdded
                                      ? Colors.green.shade400
                                      : (Theme.of(context).brightness == Brightness.dark
                                          ? Colors.white
                                          : Colors.black87),
                                ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Consumer<CurrencyProvider>(
                                builder: (context, currencyProvider, _) {
                                  return Text(
                                    currencyProvider.formatPrice(double.parse(widget.product.price)),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? Colors.amber.shade300
                                          : Colors.blue.shade800,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              if (widget.product.isAdded)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'In Cart',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade800,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Action Button
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.product.isAdded)
                        GestureDetector(
                          onTap: () {
                            widget.onTap();
                            setState(() {
                              widget.product.isAdded = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Item Removed from Cart'),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.orange.withOpacity(0.8),
                                duration: const Duration(milliseconds: 1500),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24,
                            ),
                          ),
                        )
                      else
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 6,
                            backgroundColor: Colors.blue.shade800,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 8,
                            ),
                          ),
                          onPressed: () {
                            widget.onTap();
                            setState(() {
                              widget.product.isAdded = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${widget.product.title} Added to Cart!',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.blue.shade800.withOpacity(0.8),
                                duration: const Duration(milliseconds: 1500),
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_cart_checkout_rounded,
                              size: 18),
                          label: const Text(
                            'Add',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
