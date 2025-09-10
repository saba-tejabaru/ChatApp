import 'package:firebase_auth/firebase_auth.dart';
import 'otp_provider.dart';

class FirebaseOtpProvider implements OtpProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> sendOtp(String phone, {Function(String verificationId)? onCodeSent, Function()? onAutoVerified, Function(Object error)? onFailed}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          await _auth.signInWithCredential(credential);
          onAutoVerified?.call();
        } catch (e) {
          onFailed?.call(e);
        }
      },
      verificationFailed: (FirebaseAuthException e) {
        onFailed?.call(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent?.call(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Future<bool> verifyOtp(String verificationId, String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      await _auth.signInWithCredential(credential);
      return true;
    } catch (_) {
      return false;
    }
  }
}

