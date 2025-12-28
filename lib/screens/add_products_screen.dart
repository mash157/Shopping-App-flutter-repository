import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../model/product.dart';
import '../custom_ui/product_card.dart';
import '../screens/shopping_cart_screen.dart';

//media query global variable for getting device height and width
late Size mq;

class AddProductsScreen extends StatefulWidget {
  const AddProductsScreen({super.key});

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  //list of products
  final List<Product> productsList = [
    Product(title: 'Cap', price: '99', image: 'cap.png'),
    Product(title: 'Sport Shoes', price: '499', image: 'sneakers.png'),
    Product(title: 'Backpack', price: '749', image: 'backpack.png'),
    Product(title: 'Running Shoes', price: '499', image: 'running_shoes.png'),
    Product(title: 'Hand Bag', price: '299', image: 'handbag.png'),
    Product(title: 'Rocking Horse', price: '399', image: 'rocking_horse.png'),
    Product(title: 'Smart Watch', price: '999', image: 'smart_watch.png'),
    Product(title: 'T-Shirt', price: '449', image: 't_shirt.png'),
    Product(title: 'Puzzle', price: '349', image: 'puzzle.png'),
  ];
  @override
  Widget build(BuildContext context) {
    //initialize media query variable
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        //AppBar Title With Customized Shadow
        title: const Text('Add Products'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10, // Adjust this value for a deeper shadow
        shadowColor: Colors.black.withValues(alpha: 0.9),
        surfaceTintColor: Colors
            .transparent, // Required to make elevation shadow visible in Material 3
        scrolledUnderElevation: 0,
        centerTitle: true,

        //AppBar home icon Leading and Action Icons
        leading: Icon(CupertinoIcons.home),

        //add shopping cart icon in appbar actions
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.cart),
            tooltip: 'Opening Shopping Cart',
            onPressed: () {
              // Action for cart button
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ShoppingCartScreen(
                    productsList: productsList
                        .where((e) => e.isAdded == true)
                        .toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),

      floatingActionButton: IntrinsicWidth(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none, // Allows badge to overlap edges
          children: [
            // 1. The Main Button
            FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ShoppingCartScreen(
                      productsList: productsList
                          .where((e) => e.isAdded == true)
                          .toList(),
                    ),
                  ),
                );
              },
              label: const Text('Open Cart'),
              icon: const Icon(CupertinoIcons.cart),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),

            // 2. The Badge (Red Circle)
            Positioned(
              top: -5, // Moves it slightly above the button top
              right: -5, // Moves it slightly outside the button right
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ), // Adds a nice ring
                  boxShadow: const [
                    BoxShadow(blurRadius: 4, color: Colors.black26),
                  ],
                ),
                constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                child: Center(
                  child: Text(
                    '${productsList.where((e) => e.isAdded).length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,

      body: ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: productsList[index],
            onTap: () {
              setState(() {
                productsList[index].isAdded = !productsList[index].isAdded;
              });
            },
          );
        },
      ),
    );
  }
}
