import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SymOptionNotifier extends ChangeNotifier {
  String selectedOption = '';
  onSelection(String? value) {
    selectedOption = value!;
    notifyListeners();
  }
}

final symNotifier = ChangeNotifierProvider((ref) => SymOptionNotifier());
