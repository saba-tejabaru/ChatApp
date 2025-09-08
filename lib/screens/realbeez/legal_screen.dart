import 'package:flutter/material.dart';

class LegalScreen extends StatelessWidget {
  const LegalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Legal')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(title: Text('Terms of Service')),
          Divider(),
          ListTile(title: Text('Privacy Policy')),
          Divider(),
          ListTile(title: Text('Listing Guidelines')),
        ],
      ),
    );
  }
}

