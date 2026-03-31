import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../providers/currency_provider.dart';
import '../custom_ui/product_image_widget.dart';
import 'payment_screen.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key, required this.productsList});

  final List<Product> productsList;

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  late Map<String, int> productQuantities;

  @override
  void initState() {
    super.initState();
    productQuantities = {};
    for (var product in widget.productsList) {
      productQuantities[product.title] = 1;
    }
  }

  double calculateTotal() {
    double total = 0;
    for (var product in widget.productsList) {
      int quantity = productQuantities[product.title] ?? 1;
      total += double.parse(product.price) * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    bool isEmpty = widget.productsList.isEmpty;
    double total = calculateTotal();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shopping Cart'),
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
          elevation: 8,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: isEmpty
            ? _buildEmptyCart()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Cart Items
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.productsList.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            return _buildCartItem(widget.productsList[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Billing Summary
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Billing Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 16),
                              Consumer<CurrencyProvider>(
                                builder: (context, currencyProvider, _) {
                                  final tax = total * 0.1;
                                  final shipping = total > 500 ? 0.0 : 50.0;
                                  final totalAmount = total + tax + shipping;

                                  return Column(
                                    children: [
                                      _buildBillingRow('Subtotal',
                                          currencyProvider.formatPrice(total)),
                                      const SizedBox(height: 12),
                                      _buildBillingRow('Tax (10%)',
                                          currencyProvider.formatPrice(tax)),
                                      const SizedBox(height: 12),
                                      _buildBillingRow(
                                        'Shipping',
                                        shipping == 0
                                            ? 'Free'
                                            : currencyProvider.formatPrice(shipping),
                                        color: Colors.green,
                                      ),
                                      const Divider(height: 20),
                                      _buildBillingRow(
                                        'Total Amount',
                                        currencyProvider.formatPrice(totalAmount),
                                        isBold: true,
                                        fontSize: 16,
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Checkout Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade800,
                            foregroundColor: Colors.white,
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PaymentScreen(
                                  productsList: widget.productsList,
                                  totalPrice: total,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Proceed to Payment',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Continue Shopping Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.blue.shade800,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Continue Shopping',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
        floatingActionButton: !isEmpty
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentScreen(
                        productsList: widget.productsList,
                        totalPrice: total,
                      ),
                    ),
                  );
                },
                label: const Text('Buy Now'),
                icon: const Icon(Icons.shopping_cart_checkout_rounded),
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.cart,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 24),
          Text(
            'Your Cart is Empty',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add some products to get started',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            icon: const Icon(CupertinoIcons.back),
            label: const Text('Continue Shopping'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Product product) {
    int quantity = productQuantities[product.title] ?? 1;
    double itemTotal = double.parse(product.price) * quantity;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(
                'assets/images/${product.image}',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ProductImageWidget(
                    productTitle: product.title,
                    imageUrl: product.image,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Consumer<CurrencyProvider>(
                  builder: (context, currencyProvider, _) {
                    return Text(
                      currencyProvider.formatPrice(double.parse(product.price)),
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: quantity > 1
                          ? () {
                              setState(() {
                                productQuantities[product.title] = quantity - 1;
                              });
                            }
                          : null,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text('-',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          productQuantities[product.title] = quantity + 1;
                        });
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text('+',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Consumer<CurrencyProvider>(
                builder: (context, currencyProvider, _) {
                  return Text(
                    currencyProvider.formatPrice(itemTotal),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.blue.shade800,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingRow(String label, String value,
      {bool isBold = false, Color? color, double fontSize = 14}) {
    // Use theme-aware colors for dark mode support
    Color textColor = color ?? (Theme.of(context).brightness == Brightness.dark 
        ? Colors.white 
        : Colors.black87);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: textColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isBold && color == null
                ? Colors.green.shade700
                : textColor,
          ),
        ),
      ],
    );
  }
}
