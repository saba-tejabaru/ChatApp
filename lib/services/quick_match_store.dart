import 'package:flutter/foundation.dart';

class QuickMatchStore {
  QuickMatchStore._();
  static final QuickMatchStore instance = QuickMatchStore._();

  final ValueNotifier<String?> city = ValueNotifier<String?>(null);
  final ValueNotifier<String?> purpose = ValueNotifier<String?>(null); // Buy or Rent
  final ValueNotifier<String?> budget = ValueNotifier<String?>(null); // numeric string

  void set({String? cityValue, String? purposeValue, String? budgetValue}) {
    if (cityValue != null) city.value = cityValue;
    if (purposeValue != null) purpose.value = purposeValue;
    if (budgetValue != null) budget.value = budgetValue;
  }

  void clear() {
    city.value = null;
    purpose.value = null;
    budget.value = null;
  }
}

