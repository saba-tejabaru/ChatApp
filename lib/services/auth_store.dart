import 'package:flutter/foundation.dart';
// Auth without external providers; demo OTP removed

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
    _otpVerified = true; // instantly verified since OTP flow is removed
    _verificationId = null;
  }

  Future<bool> verifyOtp(String code) async {
    return _pendingPhone != null; // OTP step skipped
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

