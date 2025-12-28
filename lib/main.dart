import 'package:flutter/material.dart';

import 'screens/add_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: Colors.blue,
              // This forces the 'surface' colors to use blue tones instead of purple
              brightness: Brightness.light,
            ).copyWith(
              // This is the background color of your cards
              surfaceContainerLow: const Color(
                0xFFE3F2FD,
              ), // A very light Blue (Blue 50)
              // Or use this if your cards use the standard surface property:
              surface: Colors.white,
            ),
        // Add this to make buttons look like the old version
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),

      title: 'Shopping App',
      home: AddProductsScreen(),
    );
  }
}
