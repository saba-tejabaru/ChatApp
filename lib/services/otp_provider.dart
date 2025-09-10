abstract class OtpProvider {
  Future<void> sendOtp(String phone, {Function(String verificationId)? onCodeSent, Function()? onAutoVerified, Function(Object error)? onFailed});
  Future<bool> verifyOtp(String verificationId, String smsCode);
}

