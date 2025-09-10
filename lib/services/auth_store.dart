import 'package:flutter/foundation.dart';
// Auth without external providers; demo OTP (code: 123456)

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
  String? _pendingPhone;
  String? _verificationId;
  bool _otpVerified = false;
  // No external OTP provider

  void signIn({required String name, required String phone, required String city}) {
    currentUser.value = AuthUser(name: name, phone: phone, city: city);
  }

  void signOut() {
    currentUser.value = null;
  }

  Future<void> requestOtp(String phone) async {
    _pendingPhone = phone;
    _otpVerified = false;
    _verificationId = 'demo';
  }

  Future<bool> verifyOtp(String code) async {
    if (_pendingPhone == null) return false;
    if (_verificationId == null) return false;
    final bool ok = code.trim() == '123456';
    _otpVerified = ok;
    return ok;
  }

  bool completeProfileAndSignIn({required String name, required String city}) {
    if (!_otpVerified || _pendingPhone == null) return false;
    signIn(name: name, phone: _pendingPhone!, city: city);
    // Clear pending OTP state post-signin
    _pendingPhone = null;
    _verificationId = null;
    _otpVerified = false;
    return true;
  }
}

