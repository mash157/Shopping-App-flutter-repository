import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../providers/currency_provider.dart';
import '../providers/auth_provider.dart';
import '../custom_ui/upi_payment_widget.dart';

class PaymentScreen extends StatefulWidget {
  final List<Product> productsList;
  final double totalPrice;

  const PaymentScreen({
    super.key,
    required this.productsList,
    required this.totalPrice,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = 'card';
  bool isProcessing = false;
  int selectedAddressIndex = 0;

  @override
  Widget build(BuildContext context) {
    double subtotal = widget.totalPrice;
    double tax = subtotal * 0.1; // 10% tax
    double shipping = subtotal > 500 ? 0 : 50; // Free shipping above 500
    double total = subtotal + tax + shipping;

    return Consumer<CurrencyProvider>(
      builder: (context, currencyProvider, _) {
        return WillPopScope(
          onWillPop: () async {
            if (!isProcessing) {
              return true;
            }
            return false;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Checkout'),
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
              elevation: 8,
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Summary
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order Summary',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 16),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.productsList.length,
                              itemBuilder: (context, index) {
                                final product = widget.productsList[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          product.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      Text(
                                        currencyProvider.formatPrice(double.parse(product.price)),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const Divider(height: 20),
                            _buildSummaryRow('Subtotal', currencyProvider.formatPrice(subtotal),
                                Colors.black87),
                            _buildSummaryRow(
                                'Tax (10%)', currencyProvider.formatPrice(tax), Colors.grey),
                            _buildSummaryRow('Shipping',
                                shipping == 0 ? 'Free' : currencyProvider.formatPrice(shipping),
                                Colors.green),
                            const Divider(height: 20),
                            _buildSummaryRow(
                              'Total',
                              currencyProvider.formatPrice(total),
                              Colors.blue.shade800,
                              isBold: true,
                              fontSize: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Payment Method Selection
                    Text(
                      'Payment Method',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentMethodCard('card', 'Credit/Debit Card',
                        CupertinoIcons.creditcard),
                    _buildPaymentMethodCard(
                        'wallet', 'Digital Wallet', Icons.wallet),
                    _buildPaymentMethodCard('upi', 'UPI', CupertinoIcons.money_dollar),
                    _buildPaymentMethodCard(
                        'bank', 'Bank Transfer', Icons.business),

                    const SizedBox(height: 24),

                    // UPI Payment Widget
                    if (selectedPaymentMethod == 'upi')
                      Column(
                        children: [
                          UPIPaymentWidget(
                            amount: total,
                            onPaymentInitiated: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Opening UPI app...'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.blue.shade800,
                                  duration: const Duration(milliseconds: 1500),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),

                    // Delivery Address
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
                            Row(
                              children: [
                                Icon(CupertinoIcons.location,
                                    color: Colors.blue.shade800),
                                const SizedBox(width: 8),
                                Text(
                                  'Delivery Address',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Consumer<AuthProvider>(
                              builder: (context, authProvider, _) {
                                final addresses =
                                    authProvider.currentUser?.addresses ?? [];
                                final currentAddress = addresses.isNotEmpty
                                    ? addresses[selectedAddressIndex]
                                    : '123 Main Street\nApartment 4B\nNew York, NY 10001';

                                return Text(
                                  currentAddress,
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                _showChangeAddressDialog();
                              },
                              child: Text(
                                'Change address',
                                style: TextStyle(
                                  color: Colors.blue.shade800,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Place Order Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                        ),
                        onPressed: isProcessing
                            ? null
                            : () {
                                _processPayment(context, total, currencyProvider);
                              },
                        child: isProcessing
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.white),
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Place Order - ${currencyProvider.formatPrice(total)}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryRow(String label, String value, Color color,
      {bool isBold = false, double fontSize = 14}) {
    // Adjust color for dark mode
    Color adjustedColor = color;
    if (Theme.of(context).brightness == Brightness.dark) {
      if (color == Colors.black87) {
        adjustedColor = Colors.white;
      } else if (color == Colors.grey) {
        adjustedColor = Colors.grey.shade400;
      } else if (color == Colors.green) {
        adjustedColor = Colors.green.shade400;
      }
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: adjustedColor,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: adjustedColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(
      String value, String label, IconData icon) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final unselectedTextColor = isDarkMode ? Colors.grey.shade300 : Colors.black87;
    final unselectedIconColor = isDarkMode ? Colors.grey.shade400 : Colors.grey;
    final unselectedBorderColor = isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300;
    final selectedColor = Colors.blue.shade800;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = value;
        });
      },
      child: Card(
        color: isDarkMode
            ? (selectedPaymentMethod == value ? Colors.grey.shade800 : Colors.grey.shade900)
            : null,
        elevation: selectedPaymentMethod == value ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: selectedPaymentMethod == value
                ? selectedColor
                : unselectedBorderColor,
            width: selectedPaymentMethod == value ? 2 : 1,
          ),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: selectedPaymentMethod == value
                    ? selectedColor
                    : unselectedIconColor,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: selectedPaymentMethod == value
                        ? selectedColor
                        : unselectedTextColor,
                  ),
                ),
              ),
              Radio<String>(
                value: value,
                groupValue: selectedPaymentMethod,
                onChanged: (val) {
                  setState(() {
                    selectedPaymentMethod = val!;
                  });
                },
                activeColor: Colors.blue.shade800,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _processPayment(BuildContext context, double total, CurrencyProvider currencyProvider) {
    setState(() {
      isProcessing = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isProcessing = false;
        });

        _showSuccessDialog(context, total, currencyProvider);
      }
    });
  }

  void _showSuccessDialog(BuildContext context, double total, CurrencyProvider currencyProvider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.check_mark,
                  size: 50,
                  color: Colors.green.shade700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Payment Successful!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your order has been placed successfully',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),
            Text(
              currencyProvider.formatPrice(total),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Back to Shopping'),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangeAddressDialog() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final addresses = authProvider.currentUser?.addresses ?? [];

    if (addresses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No addresses available')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Select Delivery Address',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAddressIndex = index;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Address changed successfully'),
                        duration: Duration(milliseconds: 1500),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: selectedAddressIndex == index
                            ? Colors.blue.shade800
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedAddressIndex == index
                                    ? Colors.blue.shade800
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: selectedAddressIndex == index
                                ? Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.blue.shade800,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              addresses[index],
                              style: TextStyle(
                                fontSize: 13,
                                color: selectedAddressIndex == index
                                    ? Colors.blue.shade800
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.color,
                                height: 1.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: Icon(
                              CupertinoIcons.pencil,
                              color: Colors.blue.shade800,
                              size: 18,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              _showEditAddressDialog(index, addresses[index]);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Confirm'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditAddressDialog(int index, String currentAddress) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final TextEditingController addressController = TextEditingController(
      text: currentAddress,
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Address'),
        content: TextFormField(
          controller: addressController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Enter your delivery address',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              if (addressController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter an address')),
                );
                return;
              }

              authProvider.updateUserAddress(index, addressController.text.trim());
              Navigator.pop(context);
              setState(() {
                // Update the display
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address updated successfully'),
                  duration: Duration(milliseconds: 1500),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
