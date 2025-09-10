import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real Beez')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _QuickMatchCard(),
          const SizedBox(height: 16),
          _SimpleGrid(
            title: 'Quick Actions',
            items: const [
              _ActionItem('Buy', Icons.home_outlined, '/explore_buy'),
              _ActionItem('Rent', Icons.key_outlined, '/explore_rent'),
              _ActionItem('Sell', Icons.sell_outlined, '/post_property'),
              _ActionItem('Loan', Icons.calculate_outlined, '/emi_calculator'),
            ],
          ),
          const SizedBox(height: 16),
          _SimpleGrid(
            title: 'Services',
            items: const [
              _ActionItem('Interiors', Icons.chair_outlined, '/interiors'),
              _ActionItem('Agreement', Icons.article_outlined, '/rent_agreement'),
              _ActionItem('Movers', Icons.local_shipping_outlined, '/home_services'),
              _ActionItem('Pay Rent', Icons.account_balance_wallet_outlined, '/utilities'),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickMatchCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('45-min Quick Match', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            const Text('Answer 3 questions. We’ll find matching properties instantly.'),
            const SizedBox(height: 12),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () => _startQuickMatch(context),
                child: const Text('Start'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startQuickMatch(BuildContext context) async {
    String? city = await _ask(context, 'Which city?');
    if (city == null) return;
    String? purpose = await _ask(context, 'Buy or Rent?');
    if (purpose == null) return;
    String? budget = await _ask(context, 'Budget (₹)?');
    if (budget == null) return;

    // Show simple result sheet
    // In a real app, kick off background matching and push results screen
    // within seconds while continuing to fetch more.
    // Here we just acknowledge.
    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Finding matches...', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('City: $city'),
            Text('Purpose: $purpose'),
            Text('Budget: ₹$budget'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            )
          ],
        ),
      ),
    );
  }

  Future<String?> _ask(BuildContext context, String question) async {
    final TextEditingController c = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(question),
        content: TextField(controller: c, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context, c.text.trim()), child: const Text('Next')),
        ],
      ),
    );
  }
}

class _SimpleGrid extends StatelessWidget {
  final String title;
  final List<_ActionItem> items;
  const _SimpleGrid({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final it = items[index];
            return InkWell(
              onTap: () {
                if (it.route != null) Navigator.pushNamed(context, it.route!);
              },
              borderRadius: BorderRadius.circular(12),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(it.icon),
                    const SizedBox(height: 6),
                    Text(it.label, textAlign: TextAlign.center),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ActionItem {
  final String label;
  final IconData icon;
  final String? route;
  const _ActionItem(this.label, this.icon, this.route);
}

