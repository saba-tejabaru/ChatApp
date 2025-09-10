import 'package:flutter/material.dart';
import '../../services/quick_match_store.dart';
import '../../services/nav_store.dart';

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
            _Dropdowns(),
            const SizedBox(height: 12),
            SizedBox(
              width: 180,
              child: ElevatedButton(
                onPressed: () => _goExplore(context),
                child: const Text('Find Properties'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goExplore(BuildContext context) {
    final qs = QuickMatchStore.instance;
    if (qs.city.value == null || qs.purpose.value == null || qs.budget.value == null) return;
    // Set bottom nav to Explore (index 1) and navigate if needed
    NavStore.instance.selectedIndex.value = 1;
  }
}

class _Dropdowns extends StatefulWidget {
  @override
  State<_Dropdowns> createState() => _DropdownsState();
}

class _DropdownsState extends State<_Dropdowns> {
  final qs = QuickMatchStore.instance;
  final List<String> cities = const ['Bengaluru', 'Mumbai', 'Pune', 'Hyderabad', 'Delhi'];
  final List<String> purposes = const ['Buy', 'Rent'];
  final List<String> budgets = const ['5000000', '8000000', '12000000', '20000000'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: qs.city.value,
            items: cities.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => qs.set(cityValue: v)),
            decoration: const InputDecoration(labelText: 'City'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: qs.purpose.value,
            items: purposes.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => qs.set(purposeValue: v)),
            decoration: const InputDecoration(labelText: 'Purpose'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: qs.budget.value,
            items: budgets.map((c) => DropdownMenuItem(value: c, child: Text('₹${_fmt(c)}'))).toList(),
            onChanged: (v) => setState(() => qs.set(budgetValue: v)),
            decoration: const InputDecoration(labelText: 'Budget'),
          ),
        ),
      ],
    );
  }

  String _fmt(String v) => v.replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',');
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

