# 🛍️ ShopHub - App Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                        ShopHub App                          │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────┐                                       │
│  │   Main Entry     │                                       │
│  │   (main.dart)    │                                       │
│  └────────┬─────────┘                                       │
│           │                                                 │
│           ▼                                                 │
│  ┌──────────────────────┐                                   │
│  │  Splash Screen       │  (3 seconds)                     │
│  │  - Animated logo     │                                   │
│  │  - Gradient BG       │                                   │
│  │  - Progress indicator│                                   │
│  └────────┬─────────────┘                                   │
│           │ ✓ Auto Navigate                                 │
│           ▼                                                 │
│  ┌──────────────────────────────────────────────┐          │
│  │     Product Listing Screen                    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Home App Bar                        │    │          │
│  │  │  [Home]  ShopHub  [Cart Count: 0]  │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Search Bar                          │    │          │
│  │  │  [Search products...]               │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Product Cards List                  │    │          │
│  │  │  ┌────────────────────────────────┐ │    │          │
│  │  │  │ 🖼️ Cap        $99    [Add]     │ │    │          │
│  │  │  ├────────────────────────────────┤ │    │          │
│  │  │  │ 🖼️ Shoes      $499   [Add]     │ │    │          │
│  │  │  ├────────────────────────────────┤ │    │          │
│  │  │  │ 🖼️ Backpack   $749   [✓Added]  │ │    │          │
│  │  │  └────────────────────────────────┘ │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Floating Button                     │    │          │
│  │  │  [🛒 Open Cart (3)]                 │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  └──────────────────────────────────────────────┘          │
│           │                                                 │
│           └─────────┬──────────────────┬─────────────────┐  │
│                    ▼                  ▼                 ▼  │
│           [Home]  [Search]      [Add/Remove]      [View Cart]│
│                                                              │
│  ┌──────────────────────────────────────────────┐          │
│  │     Shopping Cart Screen                      │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Cart App Bar                        │    │          │
│  │  │  Shopping Cart               [Back]  │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Cart Items                          │    │          │
│  │  │  ┌────────────────────────────────┐ │    │          │
│  │  │  │ 🖼️ Cap   $99  [-] 1 [+]  $99  │ │    │          │
│  │  │  ├────────────────────────────────┤ │    │          │
│  │  │  │ 🖼️ Backpack $749 [-] 1 [+] $749│ │    │          │
│  │  │  └────────────────────────────────┘ │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Billing Summary Card                │    │          │
│  │  │  Subtotal...................... $848│    │          │
│  │  │  Tax (10%)..................... $84│    │          │
│  │  │  Shipping....................... $0│    │          │
│  │  │  ─────────────────────────────────  │    │          │
│  │  │  TOTAL......................... $932│    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  [Proceed to Payment] [Continue...]  │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  └──────────────────────────────────────────────┘          │
│           │                                                 │
│           ▼                                                 │
│  ┌──────────────────────────────────────────────┐          │
│  │     Payment Screen                            │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Checkout App Bar                    │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Order Summary                       │    │          │
│  │  │  Items from cart                    │    │          │
│  │  │  Subtotal, Tax, Shipping            │    │          │
│  │  │  TOTAL AMOUNT                       │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Payment Method Selection            │    │          │
│  │  │  ○ Credit/Debit Card                │    │          │
│  │  │  ◉ Digital Wallet                   │    │          │
│  │  │  ○ UPI                              │    │          │
│  │  │  ○ Bank Transfer                    │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  Delivery Address                    │    │          │
│  │  │  📍 123 Main Street...              │    │          │
│  │  │  [Change address]                   │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  [Place Order - $932]                │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  └──────────────────────────────────────────────┘          │
│           │                                                 │
│           ▼ (Processing animation 2 sec)                    │
│           │                                                 │
│           ▼                                                 │
│  ┌──────────────────────────────────────────────┐          │
│  │     Success Confirmation Dialog              │          │
│  │  ┌─────────────────────────────────────┐    │          │
│  │  │  ✓ Payment Successful!               │    │          │
│  │  │  Order placed successfully           │    │          │
│  │  │  $932                                │    │          │
│  │  │  [Back to Shopping]                 │    │          │
│  │  └─────────────────────────────────────┘    │          │
│  └──────────────────────────────────────────────┘          │
│           │                                                 │
│           └──────────────────► Back to Home Screen 🔄      │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    Application State                        │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌──────────────────┐          ┌──────────────────────┐   │
│  │  Product List    │          │  Cart State          │   │
│  │  - title         │◄─────────┤  - isAdded (bool)    │   │
│  │  - price         │          │  - quantity (int)    │   │
│  │  - image         │          └──────────────────────┘   │
│  └──────────────────┘                                      │
│           ▲                                                 │
│           │ Update                                          │
│           │                                                 │
│  ┌──────────────────────────────────────────┐             │
│  │  StatefulWidget: AddProductsScreen       │             │
│  │  - Manages product list                  │             │
│  │  - Triggers setState on add/remove       │             │
│  └──────────────────────────────────────────┘             │
│                                                             │
│  ┌──────────────────────────────────────────┐             │
│  │  StatefulWidget: ShoppingCartScreen      │             │
│  │  - Receives filtered product list        │             │
│  │  - Manages quantities in Map             │             │
│  │  - Calculates totals                     │             │
│  └──────────────────────────────────────────┘             │
│                                                             │
│  ┌──────────────────────────────────────────┐             │
│  │  StatelessWidget: PaymentScreen          │             │
│  │  - Displays final order details          │             │
│  │  - Handles payment processing            │             │
│  │  - Shows success confirmation            │             │
│  └──────────────────────────────────────────┘             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## File Dependency Tree

```
main.dart
├── splash_screen.dart
│   └── (Routes to home)
│
└── add_products_screen.dart
    ├── model/product.dart
    ├── custom_ui/product_card.dart
    │   └── model/product.dart
    │
    └── shopping_cart_screen.dart
        ├── model/product.dart
        ├── custom_ui/product_card.dart
        │
        └── payment_screen.dart
            └── model/product.dart
```

---

## Component Interactions

```
┌──────────────┐
│ Splash Scrren│  3 seconds  Routes to home
└────────┬─────┘
         │
         ▼
┌──────────────────────┐
│  Product Listing     │
│  - Display all items │
│  - Search function   │
│  - Add to cart       ├──────┐
│  - Update UI         │      │
└────────┬─────────────┘      │
         │                    │
    Updates State     Navigates
         │                    │
         ▼                    ▼
    ┌──────────────┐    ┌──────────────┐
    │   Badge      │    │  Cart Screen │
    │   Counter    │    │ - List items │
    └──────────────┘    │ - Quantities │
                        │ - Totals     │
                        └───────┬──────┘
                                │
                           Navigates
                                │
                                ▼
                        ┌─────────────────┐
                        │ Payment Screen  │
                        │ - Order summary │
                        │ - Payment method│
                        │ - Processing    │
                        └────────┬────────┘
                                 │
                          Success → Success Dialog
                                 │
                                 ▼
                        Back to Home Screen
```

---

## Widget Hierarchy

```
MyApp
└── MaterialApp
    ├── Theme (ColorScheme, ElevatedButtonTheme)
    └── SplashScreen
        └── Scaffold
            ├── AppBar
            ├── Container (Gradient Background)
            │   └── Column
            │       ├── FadeTransition
            │       ├── ScaleTransition
            │       │   └── Picture/Icon
            │       └── CircularProgressIndicator
            └── Routes to: AddProductsScreen

AddProductsScreen
└── Scaffold
    ├── AppBar
    │   ├── Leading: Home Icon Button
    │   └── Actions: Cart Icon (with Badge)
    ├── Body: Column
    │   ├── Search TextField
    │   └── ListView
    │       └── ProductCard (repeating)
    │           ├── ScaleTransition
    │           └── Card
    │               └── Row
    │                   ├── Image
    │                   ├── Column (Info)
    │                   └── ElevatedButton/Icon
    └── FloatingActionButton.extended
        └── Badge

ShoppingCartScreen
└── Scaffold
    ├── AppBar
    ├── Body: SingleChildScrollView
    │   └── Column
    │       ├── Cart Items Card
    │       │   └── ListView
    │       │       └── CartItem (Custom)
    │       ├── Billing Summary Card
    │       │   └── Column (Rows)
    │       ├── Checkout Button
    │       └── Continue Shopping Button
    └── FloatingActionButton.extended

PaymentScreen
└── Scaffold
    ├── AppBar
    └── Body: SingleChildScrollView
        └── Column
            ├── Order Summary Card
            ├── Payment Method Cards
            │   ├── Card 1: Credit Card
            │   ├── Card 2: Wallet
            │   ├── Card 3: UPI
            │   └── Card 4: Bank
            ├── Delivery Address Card
            └── Place Order Button
```

---

## State Management Flow

```
User Action [Add to Cart]
    │
    ▼
ProductCard.onTap() called
    │
    ▼
setState() triggered in AddProductsScreen
    │
    ▼
Product.isAdded = true
    │
    ▼
Widget rebuilds
    │
    ▼
ProductCard shows "In Cart" badge
Badge counter updates
SnackBar shows confirmation
    │
    ▼
User navigates to cart
    │
    ▼
ShoppingCartScreen receives filtered list
    │
    ▼
Shows cart items with quantities
Calculates totals
    │
    ▼
User adjusts quantities
    │
    ▼
setState() updates quantities map
Totals recalculate
    │
    ▼
User proceeds to payment
    │
    ▼
PaymentScreen displays final summary
    │
    ▼
Successful payment
    │
    ▼
Success dialog appears
Back to home on dismiss
```

---

## Responsive Breakpoints

```
┌─────────────────────────────────────────────────────────┐
│  Mobile Phones       Tablets         Desktop             │
│  (320-480px)        (480-1200px)     (1200px+)          │
├─────────────────────────────────────────────────────────┤
│
│  ┌────────────┐   ┌──────────────┐   ┌──────────────┐
│  │ Compact    │   │  Tablet      │   │  Full Width  │
│  │ Layout     │   │  Layout      │   │  Layout      │
│  │            │   │              │   │              │
│  │ Single     │   │  Two Column  │   │  Multi       │
│  │ Column     │   │  (partial)   │   │  Column      │
│  │            │   │              │   │              │
│  │ Touch      │   │  Touch/      │   │  Mouse/      │
│  │ Optimized  │   │  Mouse       │   │  Keyboard    │
│  └────────────┘   └──────────────┘   └──────────────┘
│
└─────────────────────────────────────────────────────────┘
```

---

## Color & Theme Structure

```
┌──────────────────────────────────────┐
│        ThemeData Configuration       │
├──────────────────────────────────────┤
│                                      │
│  ColorScheme.fromSeed(               │
│    seedColor: Colors.blue ──┐       │
│    brightness: light        │       │
│  )                          │       │
│                            ▼       │
│  ┌─────────────────────────────┐   │
│  │  Primary: blue.shade800     │   │
│  │  Secondary: colors mixed    │   │
│  │  Surface: white             │   │
│  │  Error: red                 │   │
│  │  Success: green             │   │
│  └─────────────────────────────┘   │
│                                      │
│  ElevatedButtonThemeData             │
│    ├── backgroundColor              │
│    ├── foregroundColor               │
│    └── shape: RoundedRectangle      │
│                                      │
└──────────────────────────────────────┘
```

---

**Architecture Version: 1.0**
**Last Updated: 2024**
