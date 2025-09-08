import 'package:flutter/material.dart';

class InvestmentHotspotsScreen extends StatelessWidget {
  const InvestmentHotspotsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_Hotspot> hotspots = const [
      _Hotspot(city: 'Hyderabad', area: 'Kokapet', rationale: 'IT growth, new infra', cagr: 12.5),
      _Hotspot(city: 'Pune', area: 'Hinjewadi Phase 2', rationale: 'Tech parks, metro line', cagr: 10.1),
      _Hotspot(city: 'Bengaluru', area: 'Sarjapur Ext.', rationale: 'SEZ + connectivity', cagr: 9.4),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Investment Hotspots')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: hotspots.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final h = hotspots[index];
          return Card(
            child: ListTile(
              title: Text('${h.area}, ${h.city}'),
              subtitle: Text(h.rationale),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('5y CAGR'),
                  Text('${h.cagr.toStringAsFixed(1)}%'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Hotspot {
  final String city;
  final String area;
  final String rationale;
  final double cagr;
  const _Hotspot({required this.city, required this.area, required this.rationale, required this.cagr});
}

