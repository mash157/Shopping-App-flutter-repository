# ShopHub - Quick Reference

## 🚀 Quick Commands

```bash
# Setup
flutter pub get
flutter pub run flutter_launcher_icons:main

# Run on mobile
flutter run

# Run on web
flutter run -d chrome

# Run on Firefox
flutter run -d firefox

# Build APK
flutter build apk --release

# Build Web
flutter build web --release

# Clean cache
flutter clean && flutter pub get
```

---

## 📱 App Screens

| Screen | Description | File |
|--------|-------------|------|
| **Splash** | 3-sec animated intro | `splash_screen.dart` |
| **Home** | Product listing + search | `add_products_screen.dart` |
| **Cart** | Manage items & billing | `shopping_cart_screen.dart` |
| **Payment** | Checkout & payment | `payment_screen.dart` |

---

## 🎨 Key Features

✅ Beautiful animated splash screen
✅ Search products in real-time
✅ Add/remove items from cart
✅ Manage item quantities
✅ Automatic billing calculation
✅ Multiple payment methods
✅ Responsive mobile & web design
✅ Professional dark blue theme
✅ Smooth animations
✅ Cart item counter badge
✅ Empty state handling
✅ Success confirmation

---

## 🛠️ Project Structure

```
lib/
├── main.dart
├── model/product.dart
├── screens/
│   ├── splash_screen.dart
│   ├── add_products_screen.dart
│   ├── shopping_cart_screen.dart
│   └── payment_screen.dart
└── custom_ui/product_card.dart
```

---

## 💰 Pricing Logic

| Condition | Calculation |
|-----------|-------------|
| Subtotal | Sum of all items |
| Tax | Subtotal × 10% |
| Shipping | $50 (free if > $500) |
| **Total** | **Subtotal + Tax + Shipping** |

---

## 🎯 Navigation

```
Home → Add to Cart → View Cart → Review Billing → Select Payment → Confirm Order → Success → Home
```

---

## 📊 Colors Used

```dart
Primary:     Colors.blue.shade800      // #1565C0
Success:     Colors.green.shade100     // #C8E6C9
Alert:       Colors.red               // #F44336
Secondary:   Colors.grey.shade200     // #EEEEEE
Accent:      Colors.white             // #FFFFFF
```

---

## 🎙️ Payment Methods

1. **Credit/Debit Card** 💳
2. **Digital Wallet** 📱
3. **UPI** 🏦
4. **Bank Transfer** 🏛️

---

## 📦 Assets Required

```
assets/images/
├── cap.png
├── sneakers.png
├── backpack.png
├── running_shoes.png
├── handbag.png
├── rocking_horse.png
├── smart_watch.png
├── t_shirt.png
├── puzzle.png
├── done.png
└── icon.png
```

---

## 🧪 Testing Responsive Design

### Mobile (375×667)
```bash
flutter run -d chrome
# Open DevTools (F12) → Toggle device toolbar → Select iPhone
```

### Tablet (768×1024)
```bash
# Change device in DevTools to iPad
```

### Desktop (1920×1080)
```bash
# Default browser view
```

---

## 🔧 Common Customizations

### Change App Name
```dart
// main.dart
title: 'Your App Name'
```

### Change Primary Color
```dart
ColorScheme.fromSeed(seedColor: Colors.amber)
```

### Add Product
```dart
// add_products_screen.dart
Product(title: 'Name', price: '999', image: 'file.png')
```

### Adjust Shipping
```dart
// payment_screen.dart
double shipping = subtotal > 500 ? 0 : 50;
```

---

## 🎓 File Sizes & Dependencies

| Component | Size | Purpose |
|-----------|------|---------|
| main.dart | ~2KB | App entry |
| splash_screen.dart | ~3KB | Intro animation |
| add_products_screen.dart | ~5KB | Home page |
| shopping_cart_screen.dart | ~6KB | Cart management |
| payment_screen.dart | ~8KB | Checkout |
| product_card.dart | ~4KB | Product UI |

---

## 🚀 Deployment Checklist

- [ ] Update app name in `pubspec.yaml`
- [ ] Add custom icon: `assets/images/icon.png`
- [ ] Update all product images
- [ ] Change primary color if needed
- [ ] Test on multiple devices
- [ ] Check all payment methods
- [ ] Verify successful payments
- [ ] Test web responsiveness
- [ ] Build release APK/AAB
- [ ] Deploy to app stores

---

## 📞 Quick Fixes

**App won't launch?**
```bash
flutter clean
flutter pub get
flutter run
```

**Assets missing?**
- Verify `assets/images/` folder exists
- Check `pubspec.yaml` has correct asset paths

**Hot reload not working?**
```bash
# Restart the dev server
Ctrl+C → flutter run
```

**Web opens blank?**
```bash
flutter clean
flutter build web
flutter run -d chrome
```

---

## 📈 Performance Tips

1. Use physical device for testing performance
2. Close unnecessary background apps
3. Use `--profile` mode: `flutter run --profile`
4. Enable release mode for web: `flutter build web --release`
5. Monitor frame rate with DevTools

---

## 🎯 Next Steps

1. **Customize**: Update colors, branding, products
2. **Test**: Run on multiple devices
3. **Deploy**: Build release versions
4. **Monitor**: Track user feedback
5. **Enhance**: Add new features

---

## 📞 Support Resources

- **Flutter Docs**: https://flutter.dev/docs
- **Dart Docs**: https://dart.dev/guides
- **Material Design**: https://material.io/design
- **Community**: https://flutter.dev/community

---

**ShopHub** - A Premium Shopping Experience 🛍️

*Version: 1.0.0 | Last Updated: 2024*
