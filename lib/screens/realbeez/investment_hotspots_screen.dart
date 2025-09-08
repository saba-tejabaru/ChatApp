import 'package:flutter/material.dart';
import '../../widgets/common/metric_tile.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LayoutBuilder(builder: (context, constraints) {
                  final avgCagr = hotspots.map((e) => e.cagr).reduce((a, b) => a + b) / hotspots.length;
                  final isWide = constraints.maxWidth > 600;
                  final tiles = [
                    Expanded(child: MetricTile(title: 'Avg CAGR (5y)', value: '${avgCagr.toStringAsFixed(1)}%')),
                    const SizedBox(width: 16),
                    Expanded(child: MetricTile(title: 'Top City', value: hotspots.first.city)),
                    const SizedBox(width: 16),
                    Expanded(child: MetricTile(title: 'Hotspots', value: hotspots.length.toString())),
                  ];
                  return isWide ? Row(children: tiles) : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    MetricTile(title: 'Avg CAGR (5y)', value: '${avgCagr.toStringAsFixed(1)}%'),
                    const SizedBox(height: 12),
                    MetricTile(title: 'Top City', value: hotspots.first.city),
                    const SizedBox(height: 12),
                    MetricTile(title: 'Hotspots', value: hotspots.length.toString()),
                  ]);
                }),
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
          ],
        ),
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

