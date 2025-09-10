import 'package:flutter/foundation.dart';

class AuthUser {
  final String name;
  final String phone;
  final String city;
  const AuthUser({required this.name, required this.phone, required this.city});
}

class AuthStore {
  AuthStore._();
  static final AuthStore instance = AuthStore._();

  final ValueNotifier<AuthUser?> currentUser = ValueNotifier<AuthUser?>(null);

  void signIn({required String name, required String phone, required String city}) {
    currentUser.value = AuthUser(name: name, phone: phone, city: city);
  }

  void signOut() {
    currentUser.value = null;
  }
}

