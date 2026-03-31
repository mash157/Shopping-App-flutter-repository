# ShopHub - Premium Shopping App

A modern, premium Flutter shopping application with a beautiful UI, splash screen, cart management, billing details, payment processing, and full responsiveness for both mobile and web platforms.

## Features

### ✨ Core Features
- **Splash Screen**: Beautiful animated splash screen with app logo and branding
- **Product Browsing**: Elegant product listing with detailed information
- **Search Functionality**: Search products by name for easy navigation
- **Smart Shopping Cart**: Add/Remove items with visual feedback
- **Quantity Management**: Update quantity directly from the cart
- **Billing Summary**: Automatic tax and shipping calculations
  - 10% tax on subtotal
  - Free shipping on orders over $500
  - Standard $50 shipping for orders under $500

### 💳 Payment Features
- **Multiple Payment Methods**: Credit/Debit Card, Digital Wallet, UPI, Bank Transfer
- **Order Summary**: Detailed itemized receipt
- **Delivery Address**: Address management with change options
- **Payment Processing**: 2-second processing animation with success confirmation

### 🎨 Premium UI/UX
- **Dark Blue Theme**: Professional gradient backgrounds
- **Smooth Animations**: Scale transitions and fade effects
- **Premium Cards**: Elevated cards with custom borders and shadows
- **Responsive Design**: Adapts perfectly to mobile and web
- **Interactive Feedback**: SnackBars and visual confirmations

### 🏠 Navigation
- **Functional Home Icon**: Navigate from cart back to shopping
- **Floating Action Buttons**: Quick access to cart with item count badge
- **Cart Badge**: Real-time cart item counter
- **Easy Navigation**: Intuitive navigation between screens

### 📱 Cross-Platform Support
- **Mobile**: Optimized for iOS and Android devices
- **Web**: Full responsive design for desktop and tablet browsers
- **Responsive Layouts**: Uses MediaQuery for dynamic sizing

## Getting Started

### Prerequisites
- Flutter SDK (version 3.10.4 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Web browser (for web development)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Shopping-App-flutter-repository-master
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run app with flutter launcher icons**
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

### Running the App

#### Mobile (Android)
```bash
flutter run
```

#### Mobile (iOS)
```bash
flutter run -d <device-id>
```

#### Web (Chrome)
```bash
flutter run -d chrome
```

#### Web (Firefox)
```bash
flutter run -d firefox
```

#### Build for Release
```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# Web
flutter build web

# iOS
flutter build ios
```

## Project Structure

```
lib/
├── main.dart                 # App entry point with splash screen
├── model/
│   └── product.dart         # Product data model
├── screens/
│   ├── splash_screen.dart   # Animated splash screen
│   ├── add_products_screen.dart  # Home page with product listing
│   ├── shopping_cart_screen.dart # Cart with billing details
│   └── payment_screen.dart   # Payment processing
└── custom_ui/
    └── product_card.dart    # Reusable product card widget
```

## App Screens

### 1. Splash Screen
- 3-second animated intro
- Gradient background
- App logo display
- Progress indicator

### 2. Product Listing
- Search functionality
- Product cards with:
  - Product image
  - Title and price
  - Add to cart button
  - Status indicator when in cart
- Floating cart button with item counter
- Premium blue theme

### 3. Shopping Cart
- Product listing with:
  - Product image
  - Price per item
  - Quantity controls (+/-)
  - Item total
- Billing summary showing:
  - Subtotal
  - Tax calculation
  - Shipping cost
  - Total amount
- Empty cart state with call-to-action
- Proceed to Payment button

### 4. Payment Screen
- Complete order summary
- Payment method selection:
  - Credit/Debit Card
  - Digital Wallet
  - UPI
  - Bank Transfer
- Delivery address display
- Order processing
- Success confirmation dialog

## Customization

### Colors
The app uses a professional blue color scheme. To customize:
1. Edit `Colors.blue.shade800` throughout the code
2. Update `ColorScheme.fromSeed(seedColor: Colors.blue)` in `main.dart`

### Products
Modify the `productsList` in [add_products_screen.dart](lib/screens/add_products_screen.dart):
```dart
final List<Product> productsList = [
  Product(title: 'Cap', price: '99', image: 'cap.png'),
  // Add more products here
];
```

### Pricing
- Tax rate: Modify `double tax = subtotal * 0.1;` in payment_screen.dart
- Shipping: Modify `double shipping = subtotal > 500 ? 0 : 50;` conditions

## Features in Detail

### Search Functionality
- Real-time filtering of products
- Case-insensitive search
- Shows "No products found" for empty results

### Cart Management
- Add/remove items with instant UI update
- Quantity controls for cart items
- Automatic total calculation
- Item counter badge on home screen

### Payment Processing
- 2-second processing animation
- Success dialog with order details
- Returns to home screen after successful payment

### Responsive Design
- Works on all device sizes
- Adapts to landscape and portrait
- Web and mobile optimized layouts

## Dependencies

- `flutter`: Flutter SDK
- `cupertino_icons`: iOS-style icons
- `provider`: State management (available if needed)
- `flutter_launcher_icons`: App icon generation

## Testing

The app includes:
- Visual feedback for all interactions
- Error handling for missing assets
- Empty state handling
- Input validation (payment methods)

## Troubleshooting

### Assets not loading
Ensure `assets/images/` directory exists with all product images

### Splash screen not showing
Clear app cache: `flutter clean && flutter pub get`

### Web not running
Enable web support: `flutter config --enable-web`

### Icon not displaying
Run: `flutter pub run flutter_launcher_icons:main`

## Future Enhancements

- User authentication and profiles
- Product wishlist functionality
- Order history and tracking
- Product reviews and ratings
- Real payment gateway integration
- Multiple language support
- Dark mode theme
- Advanced filtering options

## License

This project is open source and available under the MIT License.

## Support

For support, issues, or feature requests, please open an issue in the repository.

---

**Happy Shopping with ShopHub!** 🛍️
