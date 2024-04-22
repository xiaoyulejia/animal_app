import 'package:flutter/material.dart';

class UserProfileProvider with ChangeNotifier {
  String? _imagePath;

  String? get imagePath => _imagePath;

  void setImagePath(String newPath) {
    _imagePath = newPath;
    notifyListeners();
  }
}