import 'package:flutter/foundation.dart';
import 'otp_provider.dart';

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
  OtpProvider? otpProvider;

  void signIn({required String name, required String phone, required String city}) {
    currentUser.value = AuthUser(name: name, phone: phone, city: city);
  }

  void signOut() {
    currentUser.value = null;
  }

  Future<void> requestOtp(String phone) async {
    _pendingPhone = phone;
    _otpVerified = false;
    if (otpProvider == null) {
      // fallback demo provider behavior
      _verificationId = 'demo';
      return;
    }
    await otpProvider!.sendOtp(phone, onCodeSent: (id) => _verificationId = id, onAutoVerified: () => _otpVerified = true, onFailed: (_) {});
  }

  Future<bool> verifyOtp(String code) async {
    if (_pendingPhone == null) return false;
    if (otpProvider == null) {
      final ok = code.trim() == '123456';
      _otpVerified = ok;
      return ok;
    }
    if (_verificationId == null) return false;
    final ok = await otpProvider!.verifyOtp(_verificationId!, code);
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

