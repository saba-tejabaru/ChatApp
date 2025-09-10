import 'package:flutter/foundation.dart';

class NavStore {
  NavStore._();
  static final NavStore instance = NavStore._();

  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
}

