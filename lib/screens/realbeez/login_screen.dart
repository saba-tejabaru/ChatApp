import 'package:flutter/material.dart';
import '../../services/auth_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _step = 0; // 0: phone, 1: otp, 2: details
  final _phoneKey = GlobalKey<FormState>();
  final _otpKey = GlobalKey<FormState>();
  final _detailsKey = GlobalKey<FormState>();

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _city = TextEditingController();

  bool _sending = false;
  int _resendIn = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _buildStep(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep() {
    if (_step == 0) return _buildPhone();
    if (_step == 1) return _buildOtp();
    return _buildDetails();
  }

  Widget _buildPhone() {
    return Form(
      key: _phoneKey,
      child: Column(
        key: const ValueKey('phone'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter your phone number', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextFormField(
            controller: _phone,
            decoration: const InputDecoration(labelText: 'Phone Number'),
            keyboardType: TextInputType.phone,
            validator: (v) => (v == null || v.trim().length < 8) ? 'Enter valid phone' : null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _sending ? null : _requestOtp,
              child: Text(_sending ? 'Sending...' : 'Send OTP'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOtp() {
    return Form(
      key: _otpKey,
      child: Column(
        key: const ValueKey('otp'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Enter OTP sent to ${_phone.text}', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextFormField(
            controller: _otp,
            decoration: const InputDecoration(labelText: '6-digit OTP'),
            keyboardType: TextInputType.number,
            validator: (v) => (v == null || v.trim().length != 6) ? 'Enter 6-digit OTP' : null,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              TextButton(onPressed: _resendIn > 0 ? null : _requestOtp, child: Text(_resendIn > 0 ? 'Resend in $_resendIn s' : 'Resend OTP')),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: _verifyOtp, child: const Text('Verify')),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Form(
      key: _detailsKey,
      child: Column(
        key: const ValueKey('details'),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Complete your profile', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Full Name'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _city,
            decoration: const InputDecoration(labelText: 'City'),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_detailsKey.currentState!.validate()) {
                  final ok = AuthStore.instance.completeProfileAndSignIn(name: _name.text.trim(), city: _city.text.trim());
                  if (ok) Navigator.pop(context);
                }
              },
              child: const Text('Continue'),
            ),
          )
        ],
      ),
    );
  }

  void _requestOtp() async {
    if (!_phoneKey.currentState!.validate()) return;
    setState(() => _sending = true);
    await Future.delayed(const Duration(milliseconds: 600));
    AuthStore.instance.requestOtp(_phone.text.trim());
    setState(() {
      _sending = false;
      _step = 1;
      _resendIn = 30;
    });
    _startResendTimer();
  }

  void _startResendTimer() async {
    while (_resendIn > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() => _resendIn -= 1);
    }
  }

  void _verifyOtp() {
    if (!_otpKey.currentState!.validate()) return;
    final ok = AuthStore.instance.verifyOtp(_otp.text.trim());
    if (ok) {
      setState(() => _step = 2);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid or expired OTP')));
    }
  }
}

