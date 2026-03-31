# ShopHub Setup & Running Guide

## 📋 Prerequisites

Before running the ShopHub app, ensure you have:

1. **Flutter SDK** (version 3.10.4 or later)
   - Download from: https://flutter.dev/docs/get-started/install

2. **Dart SDK** (included with Flutter)

3. **System Requirements**
   - Windows 10/11, macOS 10.15+, or Linux
   - Minimum 100MB free disk space

4. **For Mobile Development**
   - Android Studio + Android SDK (for Android)
   - Xcode (for iOS - macOS only)

5. **For Web Development**
   - Any modern web browser (Chrome, Firefox, Safari)

## 🚀 Quick Start

### 1. Clone and Setup
```bash
# Navigate to project directory
cd Shopping-App-flutter-repository-master

# Get all dependencies
flutter pub get

# Generate app icons
flutter pub run flutter_launcher_icons:main

# Clean build cache
flutter clean
```

### 2. Verify Setup
```bash
# Check Flutter installation
flutter doctor

# Check available devices
flutter devices
```

## 📱 Running on Mobile

### Android Device/Emulator

**Option 1: Using Android Emulator**
```bash
# Open Android Studio > Virtual Device Manager > Create/Start emulator
# Then run:
flutter run
```

**Option 2: Using Physical Android Phone**
```bash
# Enable USB Debugging:
# 1. Go to Settings > Developer Options > USB Debugging (enable it)
# 2. Connect phone via USB
# 3. Run:
flutter run

# For release build:
flutter build apk

# Install APK:
adb install build/app/outputs/flutter-apk/app-release.apk
```

### iOS Device/Simulator (macOS only)

**Option 1: Using iOS Simulator**
```bash
# Start simulator
open -a Simulator

# Run app
flutter run

# Or specify target
flutter run -d "iPhone 14"
```

**Option 2: Using Physical iPhone**
```bash
# 1. Connect iPhone via USB
# 2. Trust the computer on Phone
# 3. Run:
flutter run

# Build for Release:
flutter build ios

# Install on device using Xcode
open ios/Runner.xcworkspace
```

## 🌐 Running on Web

### Prerequisites for Web
```bash
# Enable web support (if not already enabled)
flutter config --enable-web

# Verify web is enabled
flutter devices  # Should show one or more web devices
```

### Chrome (Recommended)
```bash
flutter run -d chrome
```
- Automatically opens http://localhost:port in Chrome
- Hot reload supported
- Responsive design testing available

### Firefox
```bash
flutter run -d firefox
```

### Safari (macOS only)
```bash
flutter run -d safari
```

### Edge (Windows)
```bash
flutter run -d edge
```

## 🎨 Testing Responsive Design

### In Browser DevTools
1. Open the app in browser
2. Press `F12` or `Cmd+Option+I` to open DevTools
3. Click responsive design mode button
4. Test different screen sizes:
   - Mobile: 375×667 (iPhone)
   - Tablet: 768×1024 (iPad)
   - Desktop: 1920×1080

### Manual Testing Commands
```bash
# Run with specific size simulation
flutter run -d chrome --debug-port 12345

# Toggle fullscreen: Alt+Enter (Windows) or Cmd+Ctrl+F (Mac)
```

## 🏗️ Building for Release

### Android APK (for distribution)
```bash
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

### Web Build
```bash
flutter build web --release

# Output: build/web/
# Upload the entire 'build/web' folder to your web hosting
```

### iOS Build (macOS only)
```bash
flutter build ios --release

# Output: build/ios/iphoneos/Runner.app
# Use Xcode to submit to App Store
```

## 🔧 Troubleshooting

### Issue: "Flutter not found"
```bash
# Add Flutter to PATH
# Windows: Add Flutter to System Environment Variables
# macOS/Linux: Add to ~/.bashrc or ~/.zshrc:
export PATH="$PATH:$HOME/path/to/flutter/bin"
```

### Issue: App crashes on startup
```bash
# Clear all caches and rebuild
flutter clean
flutter pub get
flutter run
```

### Issue: Assets not loading
```bash
# Verify assets directory exists
ls assets/images/

# Ensure pubspec.yaml has correct asset paths
# Then run:
flutter run
```

### Issue: Hot reload not working
```bash
# Restart the development server
# Press Ctrl+C to stop
# Run again:
flutter run
```

### Issue: Web app opens blank page
```bash
# Clear browser cache and rebuild
flutter clean
flutter build web
flutter run -d chrome
```

### Issue: "Device not found"
```bash
# List available devices
flutter devices

# For Android: Check adb daemon
adb devices

# For iOS: Check provisioning profiles in Xcode
```

## 🎯 Default Routes

When you run the app, here's the navigation flow:

1. **Splash Screen** → Shows for 3 seconds
2. **Product Listing** → Main shopping page
3. **Shopping Cart** → View items and billing
4. **Payment** → Complete checkout

## 📊 Performance Tips

### For Mobile Development
- Close unnecessary background apps
- Use a physical device for better performance
- Use `--profile` mode for performance testing:
  ```bash
  flutter run --profile
  ```

### For Web Development
- Use Chrome for best debugging experience
- Enable debug mode for detailed error messages
- Use DevTools for performance profiling

## 🐛 Debugging

### Enable Verbose Logging
```bash
flutter run -v

# Or with web:
flutter run -d chrome -v
```

### Open Flutter DevTools
```bash
# In a new terminal while app is running
flutter pub global activate devtools
devtools
```

### Debug with specific options
```bash
# Debug Android with logcat
flutter run --debug -v | grep "flutter log"

# Debug web with browser DevTools
# Press Ctrl+Shift+I in browser while running
```

## 📦 Project Dependencies

Current dependencies in `pubspec.yaml`:
- `flutter`: SDK
- `cupertino_icons`: ^1.0.8
- `provider`: ^6.1.5+1 (available for state management)
- `flutter_launcher_icons`: ^0.14.4 (for app icons)

To add more dependencies:
```bash
flutter pub add <package_name>
flutter pub get
```

## 🌍 Environment Variables (Optional)

Create a `.env` file for configuration:
```
API_BASE_URL=https://api.example.com
APP_VERSION=1.0.0
```

## 📲 Multi-Device Testing

### Test on Multiple Devices Simultaneously
```bash
# Run on all available devices
flutter run

# Then select which device to run on (interactive)
```

## 🎯 Pro Tips

1. **Hot Reload**: Press 'r' while app is running to see changes instantly
2. **Hot Restart**: Press 'R' to restart the entire app
3. **DevTools**: Press 'd' to open DevTools in browser
4. **Quit**: Press 'q' to exit the app

## 📈 Version Management

Current version: **1.0.0**

To bump version:
```bash
# Update pubspec.yaml
version: 1.1.0+2
```

Format: `major.minor.patch+buildNumber`

## 🎓 Learning Resources

- [Flutter Official Documentation](https://flutter.dev/docs)
- [Dart Language Guide](https://dart.dev/guides)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Flutter Community](https://flutter.dev/community)

## 📞 Support Commands

```bash
# Check Flutter installation
flutter doctor

# Check installed packages
flutter pub deps

# Upgrade Flutter
flutter upgrade

# Check for outdated packages
flutter pub outdated
```

---

## 🚀 Next Steps

1. Customize app branding and colors
2. Add real product data from API
3. Integrate real payment gateway
4. Deploy to app stores
5. Monitor user analytics

**Happy Development! 🎉**
