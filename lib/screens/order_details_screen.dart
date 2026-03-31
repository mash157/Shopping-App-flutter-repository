import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({
    super.key,
    required this.order,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: Colors.blue.shade800,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Order Status Card
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blue.shade800,
                    Colors.blue.shade600,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #${order.id.substring(0, 8)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      order.status.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Order Timeline
          _buildTimeline(context),
          const SizedBox(height: 24),
          // Delivery Address
          _buildSection(
            context,
            'Delivery Address',
            [
              Text(
                order.deliveryAddress,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Order Dates
          _buildSection(
            context,
            'Dates',
            [
              _buildDateRow(
                'Order Placed',
                DateFormat('MMM dd, yyyy - hh:mm a').format(order.orderDate),
              ),
              const SizedBox(height: 12),
              if (order.deliveryDate != null)
                _buildDateRow(
                  'Delivery Date',
                  DateFormat('MMM dd, yyyy').format(order.deliveryDate!),
                ),
            ],
          ),
          const SizedBox(height: 20),
          // Payment Method
          _buildSection(
            context,
            'Payment Method',
            [
              Row(
                children: [
                  Icon(
                    order.paymentMethod == 'Credit Card'
                        ? Icons.credit_card
                        : order.paymentMethod == 'Debit Card'
                        ? Icons.credit_card
                        : Icons.account_balance_wallet,
                    color: Colors.blue.shade800,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    order.paymentMethod,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Order Items
          _buildSection(
            context,
            'Order Items',
            [
              ...order.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Qty: ${item.quantity} × \$${double.parse(item.price).toStringAsFixed(2)}',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '\$${item.itemTotal.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
          const SizedBox(height: 20),
          // Price Breakdown
          _buildSection(
            context,
            'Price Breakdown',
            [
              _buildPriceRow('Subtotal', order.subtotal),
              const SizedBox(height: 12),
              _buildPriceRow('Tax (10%)', order.tax),
              const SizedBox(height: 12),
              _buildPriceRow('Shipping', order.shipping),
              if (order.appliedCoupon != null && order.appliedCoupon!.isNotEmpty)
                ...[
                  const SizedBox(height: 12),
                  _buildPriceRow(
                    'Coupon: ${order.appliedCoupon}',
                    -5.0, // Assuming fixed discount for demo
                    isDiscount: true,
                  ),
                ],
              const SizedBox(height: 16),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 12),
              _buildPriceRow('Total Amount', order.total, isTotal: true),
            ],
          ),
          const SizedBox(height: 24),
          // Action Buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade800,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.receipt_long),
              label: const Text('Download Invoice'),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invoice download feature coming soon!'),
                    backgroundColor: Colors.blue,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.support_agent, color: Colors.blue.shade800),
              label: Text(
                'Contact Support',
                style: TextStyle(color: Colors.blue.shade800),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Support contact feature coming soon!'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final states = ['pending', 'processing', 'shipped', 'delivered'];
    final currentIndex = states.indexOf(order.status);

    return Column(
      children: [
        Text(
          'Order Status',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          children: List.generate(states.length, (index) {
            final isCompleted = index <= currentIndex;
            final isLast = index == states.length - 1;

            return Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: isCompleted
                              ? Colors.green
                              : Colors.grey.shade300,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                          isCompleted ? Colors.green : Colors.grey.shade300,
                        ),
                        child: Icon(
                          isCompleted ? Icons.check : null,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: isCompleted
                                ? Colors.green
                                : Colors.grey.shade300,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    states[index].toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isCompleted
                          ? Colors.green
                          : Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateRow(String label, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Text(
          date,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPriceRow(String label, double amount,
      {bool isDiscount = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          '${isDiscount ? '- ' : ''}\$${amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
            color: isDiscount ? Colors.green : null,
          ),
        ),
      ],
    );
  }
}
