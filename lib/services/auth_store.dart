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
  String? _pendingPhone;
  String? _otpCode;
  DateTime? _otpExpiry;
  bool _otpVerified = false;

  void signIn({required String name, required String phone, required String city}) {
    currentUser.value = AuthUser(name: name, phone: phone, city: city);
  }

  void signOut() {
    currentUser.value = null;
  }

  void requestOtp(String phone) {
    _pendingPhone = phone;
    // Demo OTP code. In production, call SMS gateway and do not store OTP in memory.
    _otpCode = '123456';
    _otpExpiry = DateTime.now().add(const Duration(minutes: 5));
    _otpVerified = false;
  }

  bool verifyOtp(String code) {
    if (_otpCode == null || _pendingPhone == null || _otpExpiry == null) return false;
    if (DateTime.now().isAfter(_otpExpiry!)) return false;
    final ok = code.trim() == _otpCode;
    _otpVerified = ok;
    return ok;
  }

  bool completeProfileAndSignIn({required String name, required String city}) {
    if (!_otpVerified || _pendingPhone == null) return false;
    signIn(name: name, phone: _pendingPhone!, city: city);
    // Clear pending OTP state post-signin
    _pendingPhone = null;
    _otpCode = null;
    _otpExpiry = null;
    _otpVerified = false;
    return true;
  }
}

