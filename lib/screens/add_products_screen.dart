
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../model/product.dart';
import '../custom_ui/product_card.dart';
import '../screens/shopping_cart_screen.dart';
import '../screens/user_profile_screen.dart';
import '../screens/order_history_screen.dart';
import '../screens/settings_screen.dart';

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
    // Clothing
    Product(
      id: '1',
      title: 'Cap',
      price: '99',
      image: 'cap.png',
      description: 'Stylish cotton cap perfect for outdoor activities. Adjustable fit with premium embroidery. Breathable material keeps you cool all day.',
      category: 'Clothing',
      rating: 4.5,
      reviewCount: 128,
    ),
    Product(
      id: '2',
      title: 'T-Shirt',
      price: '449',
      image: 't_shirt.jpg',
      description: 'High-quality 100% organic cotton t-shirt. Comfortable fit with vibrant colors. Perfect for casual wear and everyday use.',
      category: 'Clothing',
      rating: 4.7,
      reviewCount: 256,
    ),
    Product(
      id: '3',
      title: 'Blue Jeans',
      price: '599',
      image: 'jeans.webp',
      description: 'Classic blue denim jeans with perfect fit. Durable fabric with stylish design. Suitable for all occasions and seasons.',
      category: 'Clothing',
      rating: 4.6,
      reviewCount: 189,
    ),
    Product(
      id: '4',
      title: 'Summer Dress',
      price: '799',
      image: 'dress.png',
      description: 'Elegant summer dress with floral patterns. Lightweight and breathable fabric. Perfect for beach and vacation trips.',
      category: 'Clothing',
      rating: 4.8,
      reviewCount: 342,
    ),
    Product(
      id: '5',
      title: 'Formal Shirt',
      price: '799',
      image: 'formal_shirt.webp',
      description: 'Premium formal shirt for business and office wear. Wrinkle-resistant fabric for easy maintenance. Available in multiple colors.',
      category: 'Clothing',
      rating: 4.4,
      reviewCount: 167,
    ),

    // Footwear
    Product(
      id: '6',
      title: 'Sport Shoes',
      price: '499',
      image: 'sneakers.jpg',
      description: 'High-performance sport shoes with cushioned sole. Lightweight design for running and workouts. Breathable mesh upper for comfort.',
      category: 'Footwear',
      rating: 4.7,
      reviewCount: 432,
    ),
    Product(
      id: '7',
      title: 'Running Shoes',
      price: '499',
      image: 'running_shoes.jpg',
      description: 'Professional running shoes with advanced shock absorption. Perfect for marathons and daily running. Durable outsole for better grip.',
      category: 'Footwear',
      rating: 4.9,
      reviewCount: 521,
    ),
    Product(
      id: '8',
      title: 'Casual Sneakers',
      price: '449',
      image: 'casual_shoes.png',
      description: 'Trendy casual sneakers perfect for everyday wear. Comfortable padding with stylish design. Best seller among young adults.',
      category: 'Footwear',
      rating: 4.6,
      reviewCount: 398,
    ),
    Product(
      id: '9',
      title: 'Formal Shoes',
      price: '899',
      image: 'formal_shoes.jpg',
      description: 'Elegant formal shoes for business meetings and events. Premium leather construction with polished finish. Comfortable for all-day wear.',
      category: 'Footwear',
      rating: 4.5,
      reviewCount: 245,
    ),
    Product(
      id: '10',
      title: 'Sandals',
      price: '249',
      image: 'sandals.jpg',
      description: 'Comfortable sandals for summer. Lightweight and easy to wear. Perfect for beach and casual outings.',
      category: 'Footwear',
      rating: 4.3,
      reviewCount: 156,
    ),

    // Accessories
    Product(
      id: '11',
      title: 'Smart Watch',
      price: '999',
      image: 'smart_watch.jpg',
      description: 'Features fitness tracking, heart rate monitor, and notifications. Water-resistant design. Battery lasts up to 7 days.',
      category: 'Accessories',
      rating: 4.8,
      reviewCount: 589,
    ),
    Product(
      id: '12',
      title: 'Hand Bag',
      price: '299',
      image: 'handbag.jpg',
      description: 'Elegant hand bag with spacious compartments. Premium materials with stylish design. Perfect for office and casual use.',
      category: 'Accessories',
      rating: 4.4,
      reviewCount: 198,
    ),
    Product(
      id: '13',
      title: 'Backpack',
      price: '749',
      image: 'backpack.png',
      description: 'Durable backpack with laptop compartment. Multiple pockets for organization. Ergonomic design for comfortable carrying.',
      category: 'Accessories',
      rating: 4.7,
      reviewCount: 467,
    ),
    Product(
      id: '14',
      title: 'Designer Wallet',
      price: '449',
      image: 'wallet.jpg',
      description: 'Compact designer wallet with RFID protection. Multiple card slots and coin compartment. Premium leather finish.',
      category: 'Accessories',
      rating: 4.6,
      reviewCount: 234,
    ),
    Product(
      id: '15',
      title: 'Sunglasses',
      price: '599',
      image: 'sunglasses.jpg',
      description: 'UV protection sunglasses with polarized lenses. Stylish frame design. Perfect for outdoor activities.',
      category: 'Accessories',
      rating: 4.5,
      reviewCount: 312,
    ),
    Product(
      id: '16',
      title: 'Sports Watch',
      price: '1299',
      image: 'sports_watch.jpg',
      description: 'Advanced sports watch with GPS and altitude tracking. Durable titanium case. Perfect for athletes and outdoor enthusiasts.',
      category: 'Accessories',
      rating: 4.9,
      reviewCount: 445,
    ),

    // Electronics
    Product(
      id: '17',
      title: 'Wireless Earbuds',
      price: '1299',
      image: 'earbuds.png',
      description: 'True wireless earbuds with noise cancellation. 24-hour battery with charging case. Crystal clear sound quality.',
      category: 'Electronics',
      rating: 4.8,
      reviewCount: 678,
    ),
    Product(
      id: '18',
      title: 'Phone Stand',
      price: '199',
      image: 'phone_stand.jpg',
      description: 'Adjustable phone stand for desk. Supports all smartphone sizes. Non-slip rubber pads for stability.',
      category: 'Electronics',
      rating: 4.3,
      reviewCount: 89,
    ),
    Product(
      id: '19',
      title: 'USB-C Cable',
      price: '149',
      image: 'usb_cable.jpg',
      description: 'High-speed USB-C charging cable. Durable braided design. Compatible with all USB-C devices.',
      category: 'Electronics',
      rating: 4.4,
      reviewCount: 234,
    ),
    Product(
      id: '21',
      title: 'Portable Speaker',
      price: '1099',
      image: 'speaker.jpg',
      description: 'Waterproof Bluetooth speaker with 360-degree sound. 12-hour battery life. Perfect for outdoor adventures.',
      category: 'Electronics',
      rating: 4.7,
      reviewCount: 523,
    ),

    // Home & Garden
    Product(
      id: '22',
      title: 'Coffee Maker',
      price: '1599',
      image: 'coffee_maker.png',
      description: 'Automatic coffee maker with programmable timer. Makes 12 cups per brewing. Easy to clean and maintain.',
      category: 'Home & Garden',
      rating: 4.5,
      reviewCount: 267,
    ),
    Product(
      id: '23',
      title: 'Desk Lamp',
      price: '449',
      image: 'desk_lamp.png',
      description: 'LED desk lamp with adjustable brightness. Eye-friendly lighting. USB charging port built-in.',
      category: 'Home & Garden',
      rating: 4.6,
      reviewCount: 178,
    ),
    Product(
      id: '24',
      title: 'Bed Sheets Set',
      price: '799',
      image: 'bed_sheets.png',
      description: 'Luxurious organic cotton bed sheets. 300 thread count for softness. Available in multiple colors.',
      category: 'Home & Garden',
      rating: 4.4,
      reviewCount: 298,
    ),
    Product(
      id: '25',
      title: 'Throw Pillow',
      price: '399',
      image: 'pillow.jpg',
      description: 'Comfortable decorative throw pillow. Premium fabric with elegant design. Machine washable cover.',
      category: 'Home & Garden',
      rating: 4.3,
      reviewCount: 145,
    ),

    // Sports & Outdoors
    Product(
      id: '26',
      title: 'Yoga Mat',
      price: '599',
      image: 'yoga_mat.jpg',
      description: 'Non-slip yoga mat with thickness padding. Eco-friendly material. Lightweight and portable.',
      category: 'Sports & Outdoors',
      rating: 4.7,
      reviewCount: 389,
    ),
    Product(
      id: '27',
      title: 'Dumbbells Set',
      price: '1299',
      image: 'dumbbells.png',
      description: 'Complete dumbbell set with adjustable weights. Includes storage rack. Perfect for home gym.',
      category: 'Sports & Outdoors',
      rating: 4.6,
      reviewCount: 267,
    ),
    Product(
      id: '28',
      title: 'Water Bottle',
      price: '349',
      image: 'water_bottle.jpg',
      description: 'Insulated water bottle keeps drinks cold for 24 hours. Leak-proof design. BPA-free materials.',
      category: 'Sports & Outdoors',
      rating: 4.5,
      reviewCount: 412,
    ),
    Product(
      id: '29',
      title: 'Camping Tent',
      price: '2299',
      image: 'tent.jpg',
      description: 'Weather-resistant camping tent for 4 people. Easy setup with ventilation. Durable and portable.',
      category: 'Sports & Outdoors',
      rating: 4.8,
      reviewCount: 156,
    ),

    // Kids & Toys
    Product(
      id: '30',
      title: 'Rocking Horse',
      price: '399',
      image: 'rocking_horse.jpg',
      description: 'Wooden rocking horse for toddlers. Smooth finish with safety handles. Classic design loved by kids.',
      category: 'Kids & Toys',
      rating: 4.4,
      reviewCount: 123,
    ),
    Product(
      id: '31',
      title: 'Puzzle',
      price: '349',
      image: 'puzzle.jpg',
      description: '1000-piece puzzle with beautiful scenery. Perfect for family entertainment. High-quality cardboard pieces.',
      category: 'Kids & Toys',
      rating: 4.3,
      reviewCount: 234,
    ),
    Product(
      id: '32',
      title: 'Building Blocks',
      price: '599',
      image: 'blocks.png',
      description: 'Educational building blocks for creative play. Over 500 pieces in various colors. Safe for children.',
      category: 'Kids & Toys',
      rating: 4.6,
      reviewCount: 345,
    ),
    Product(
      id: '33',
      title: 'Remote Control Car',
      price: '799',
      image: 'rc_car.jpg',
      description: 'High-speed remote control car with rechargeable battery. All-terrain wheels. Indoor and outdoor use.',
      category: 'Kids & Toys',
      rating: 4.7,
      reviewCount: 267,
    ),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    //initialize media query variable
    mq = MediaQuery.of(context).size;

    // Filter products based on search
    final filteredProducts = productsList
        .where((product) =>
            product.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        //AppBar Title With Customized Shadow
        title: const Text(
          'ShopHub',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
        elevation: 10,
        shadowColor: Colors.black.withOpacity(0.5),
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: true,

        //AppBar home icon Leading and Action Icons
        leading: IconButton(
          icon: const Icon(CupertinoIcons.home),
          onPressed: () {
            // Home icon is already on the home screen, show a snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('You are on the Home Page'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.blue.shade800.withOpacity(0.8),
              ),
            );
          },
          tooltip: 'Home',
        ),

        //add shopping cart icon in appbar actions
        actions: [
          // Order History Button
          IconButton(
            icon: const Icon(CupertinoIcons.bag),
            tooltip: 'Order History',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrderHistoryScreen(),
                ),
              );
            },
          ),
          // Settings Button
          IconButton(
            icon: const Icon(CupertinoIcons.settings),
            tooltip: 'Settings',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
          // Profile Button
          IconButton(
            icon: const Icon(CupertinoIcons.person),
            tooltip: 'Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UserProfileScreen(),
                ),
              );
            },
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.cart),
                tooltip: 'Open Shopping Cart',
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
                  ).then((value) {
                    setState(() {});
                  });
                },
              ),
              // Badge for cart count
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
                  child: Center(
                    child: Text(
                      '${productsList.where((e) => e.isAdded).length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: productsList.any((e) => e.isAdded)
          ? IntrinsicWidth(
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
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
                      ).then((value) {
                        setState(() {});
                      });
                    },
                    label: const Text('Open Cart'),
                    icon: const Icon(CupertinoIcons.cart),
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 8,
                  ),
                  Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.red.withOpacity(0.5),
                          ),
                        ],
                      ),
                      constraints:
                          const BoxConstraints(minWidth: 28, minHeight: 28),
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
            )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,

      body: Column(
        children: [
          // Search Bar with Dark Mode Support
          Padding(
            padding: EdgeInsets.all(mq.width * 0.04),
            child: Builder(
              builder: (context) {
                final isDarkMode = Theme.of(context).brightness == Brightness.dark;
                final searchFillColor = isDarkMode 
                    ? const Color(0xFF3E3E42) 
                    : Colors.grey.shade100;
                final searchIconColor = isDarkMode 
                    ? Colors.grey.shade300 
                    : Colors.grey.shade600;
                final searchTextColor = isDarkMode
                    ? Colors.white
                    : Colors.black;
                final searchHintColor = isDarkMode
                    ? Colors.grey.shade400
                    : Colors.grey.shade600;
                
                return TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  style: TextStyle(color: searchTextColor),
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: searchHintColor),
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: searchIconColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: searchFillColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                );
              },
            ),
          ),

          // Products List
          Expanded(
            child: filteredProducts.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: filteredProducts[index],
                        onTap: () {
                          setState(() {
                            filteredProducts[index].isAdded =
                                !filteredProducts[index].isAdded;
                          });
                        },
                      );
                    },
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.search,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No products found',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
