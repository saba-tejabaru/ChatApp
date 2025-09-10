import 'package:flutter/material.dart';
import '../../models/realbeez_sample.dart';
import '../../services/quick_match_store.dart';
import '../../widgets/realbeez/property_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final qs = QuickMatchStore.instance;
    final String? city = qs.city.value;
    final String? purpose = qs.purpose.value; // Buy or Rent
    final int? budget = int.tryParse(qs.budget.value ?? '0');

    // Filter helper: choose owner+verified for Buy; for Rent, we reuse verified list (as example)
    List<PropertyItem> base = [
      ...RealBeezSamples.ownerListings,
      ...RealBeezSamples.verifiedListings,
    ];
    // In a real app, separate rent samples; here we filter by keywords and price bands
    List<PropertyItem> filtered = base.where((p) {
      bool ok = true;
      if (city != null) ok = ok && p.location.toLowerCase().contains(city.toLowerCase());
      if (budget != null && budget > 0) {
        // parse numeric from price like ₹1.25 Cr or ₹72 L
        final numVal = _parsePrice(p.price);
        ok = ok && numVal <= budget;
      }
      return ok;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Explore')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: filtered.isEmpty
            ? Center(child: Text('No matches. Adjust filters on Dashboard.'))
            : ListView.separated(
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => PropertyCard(item: filtered[index]),
              ),
      ),
    );
  }

  int _parsePrice(String price) {
    String s = price.replaceAll('₹', '').replaceAll(',', '').trim();
    if (s.contains('Cr')) {
      final num v = double.tryParse(s.replaceAll('Cr', '').trim()) ?? 0;
      return (v * 10000000).round();
    }
    if (s.contains('L')) {
      final num v = double.tryParse(s.replaceAll('L', '').trim()) ?? 0;
      return (v * 100000).round();
    }
    final num v = double.tryParse(s) ?? 0;
    return v.round();
  }
}

