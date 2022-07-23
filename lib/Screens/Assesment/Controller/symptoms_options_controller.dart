import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymOptionNotifier extends ChangeNotifier {
  String selectedOption = '';
  onSelection(String? value, String result) {
    selectedOption = value!;
    result = selectedOption;
    notifyListeners();
  }
}

final symNotifier = ChangeNotifierProvider((ref) => SymOptionNotifier());
