import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../screens/add_products_screen.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product, required this.onTap});

  final Product product;
  final VoidCallback onTap;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.product.isAdded ? Colors.green[50] : null,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.symmetric(
        horizontal: mq.height * .02,
        vertical: mq.height * .02,
      ),

      child: ListTile(
        contentPadding: EdgeInsets.only(
          left: mq.width * .05,
          top: mq.height * .01,
          bottom: mq.height * .01,
          right: mq.height * .01,
        ),
        leading: Image.asset('assets/images/${widget.product.image}'),
        title: Text(widget.product.title),
        subtitle: Text('\$${widget.product.price}.00'),
        trailing: widget.product.isAdded
            ? IconButton(
                onPressed: () {
                  widget.onTap();
                  setState(() {
                    widget.product.isAdded = false;
                  });
                },
                icon: Image.asset('assets/images/done.png'),
              )
            : ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                onPressed: () {
                  widget.onTap();
                  setState(() {
                    widget.product.isAdded = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Item Added Successfully!'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.blueAccent.withOpacity(0.8),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart_checkout_rounded),
                label: const Text('Add'),
              ),
      ), // Closes ListTile
    ); // Closes Card
  } // Closes build
} // Closes State Class
