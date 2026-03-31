import 'package:flutter/material.dart';

class Currency {
  final String code;
  final String symbol;
  final String name;
  final double exchangeRate;

  const Currency({
    required this.code,
    required this.symbol,
    required this.name,
    required this.exchangeRate,
  });
}

class CurrencyProvider extends ChangeNotifier {
  static final List<Currency> _currencies = [
    const Currency(code: 'USD', symbol: '\$', name: 'US Dollar', exchangeRate: 1.0),
    const Currency(code: 'EUR', symbol: '€', name: 'Euro', exchangeRate: 0.92),
    const Currency(code: 'GBP', symbol: '£', name: 'British Pound', exchangeRate: 0.79),
    const Currency(code: 'INR', symbol: '₹', name: 'Indian Rupee', exchangeRate: 83.12),
    const Currency(code: 'AUD', symbol: 'A\$', name: 'Australian Dollar', exchangeRate: 1.53),
    const Currency(code: 'CAD', symbol: 'C\$', name: 'Canadian Dollar', exchangeRate: 1.36),
    const Currency(code: 'JPY', symbol: '¥', name: 'Japanese Yen', exchangeRate: 149.50),
    const Currency(code: 'CNY', symbol: '¥', name: 'Chinese Yuan', exchangeRate: 7.24),
    const Currency(code: 'CHF', symbol: 'CHF', name: 'Swiss Franc', exchangeRate: 0.88),
    const Currency(code: 'AED', symbol: 'د.إ', name: 'UAE Dirham', exchangeRate: 3.67),
    const Currency(code: 'SGD', symbol: 'S\$', name: 'Singapore Dollar', exchangeRate: 1.35),
    const Currency(code: 'HKD', symbol: 'HK\$', name: 'Hong Kong Dollar', exchangeRate: 7.81),
  ];

  Currency _selectedCurrency = _currencies[0]; // Default to USD

  Currency get selectedCurrency => _selectedCurrency;

  List<Currency> get currencies => _currencies;

  void setCurrency(Currency currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  double convertPrice(double priceInUSD) {
    return double.parse(
      (priceInUSD * _selectedCurrency.exchangeRate).toStringAsFixed(2),
    );
  }

  String formatPrice(double priceInUSD) {
    final converted = convertPrice(priceInUSD);
    return '${_selectedCurrency.symbol}${converted.toStringAsFixed(2)}';
  }

  String formatPriceWithCode(double priceInUSD) {
    final converted = convertPrice(priceInUSD);
    return '${_selectedCurrency.symbol}${converted.toStringAsFixed(2)} ${_selectedCurrency.code}';
  }
}
