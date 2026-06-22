import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String _selectedService = 'بطارية';
  bool _requestActive = false;
  String _currentRequestId = '';
  String _selectedPayment = 'cash';
  double _userLat = 30.0444;
  double _userLng = 31.2357;
  double _techLat = 30.0520;
  double _techLng = 31.2280;
  int _eta = 7;
  int _rating = 0;
  String _technicianName = 'محمد السيد';
  bool _technicianAssigned = false;

  String get selectedService => _selectedService;
  bool get requestActive => _requestActive;
  String get currentRequestId => _currentRequestId;
  String get selectedPayment => _selectedPayment;
  double get userLat => _userLat;
  double get userLng => _userLng;
  double get techLat => _techLat;
  double get techLng => _techLng;
  int get eta => _eta;
  int get rating => _rating;
  String get technicianName => _technicianName;
  bool get technicianAssigned => _technicianAssigned;

  final Map<String, String> servicePrices = {
    'بطارية': '150 ج.م',
    'بنزين': '100 ج.م',
    'كاوتش': '180 ج.م',
    'سحب': '350 ج.م',
    'فتح': '90 ج.م',
    'شحن': '140 ج.م',
  };

  void selectService(String service) {
    _selectedService = service;
    notifyListeners();
  }

  void setRequestActive(bool active) {
    _requestActive = active;
    if (active) {
      _currentRequestId = 'REQ-${DateTime.now().millisecondsSinceEpoch}';
      _technicianAssigned = false;
    }
    notifyListeners();
  }

  void assignTechnician() {
    _technicianAssigned = true;
    _eta = 7;
    notifyListeners();
  }

  void setPayment(String payment) {
    _selectedPayment = payment;
    notifyListeners();
  }

  void setRating(int rating) {
    _rating = rating;
    notifyListeners();
  }

  void completeRequest() {
    _requestActive = false;
    _technicianAssigned = false;
    _rating = 0;
    _currentRequestId = '';
    notifyListeners();
  }
}
