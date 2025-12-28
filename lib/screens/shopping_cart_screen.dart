import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../model/product.dart';
import '../custom_ui/product_card.dart';
import '../screens/add_products_screen.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key, required this.productsList});

  final List<Product>
  productsList; // This should be populated with actual products added to the cart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //AppBar Title With Customized Shadow
        title: const Text('Shopping Cart'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 8, // Adjust this value for a deeper shadow
        surfaceTintColor: Colors
            .transparent, // Required to make elevation shadow visible in Material 3
        centerTitle: true,

        //add shopping cart icon in appbar actions
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.cart),
            tooltip: 'Opening Shopping Cart',
            onPressed: () {
              // Action for cart button
            },
          ),
        ],
      ),

      //Floating Action Button to Open Shopping Cart
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Buy Now'),
        icon: Icon(Icons.shopping_cart_checkout_rounded),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,

      body: ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: productsList[index],
            onTap: () {
              // Handle any additional actions if needed when tapping the product card
            },
          );
        },
      ),
    );
  }
}
