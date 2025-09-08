import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = const [
      _Faq(q: 'How to post my property?', a: 'Go to Post Property and fill details. Verification may apply.'),
      _Faq(q: 'How do I get a home loan?', a: 'Use the EMI Calculator and connect with partner banks.'),
      _Faq(q: 'What is a verified listing?', a: 'Verified by our team via documents and calls.'),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help Center'),
          bottom: const TabBar(tabs: [Tab(text: 'FAQs'), Tab(text: 'Contact'), Tab(text: 'Guides')]),
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final f = faqs[index];
                return ExpansionTile(title: Text(f.q), children: [Padding(padding: const EdgeInsets.all(12), child: Text(f.a))]);
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: faqs.length,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Email: support@realbeez.com'),
                  SizedBox(height: 8),
                  Text('Phone: +91 99999 99999'),
                ],
              ),
            ),
            ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                ListTile(title: Text('Buyer Guide'), subtitle: Text('From search to registration')), 
                ListTile(title: Text('Tenant Guide'), subtitle: Text('Agreements & verification')),
                ListTile(title: Text('Seller Guide'), subtitle: Text('Listing to closure')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Faq {
  final String q;
  final String a;
  const _Faq({required this.q, required this.a});
}

