import 'package:flutter/material.dart';
import '../../widgets/common/metric_tile.dart';

class RatesTrendsScreen extends StatefulWidget {
  const RatesTrendsScreen({super.key});

  @override
  State<RatesTrendsScreen> createState() => _RatesTrendsScreenState();
}

class _RatesTrendsScreenState extends State<RatesTrendsScreen> {
  final TextEditingController _cityController = TextEditingController(text: 'Bengaluru');
  List<_Trend> _trends = const [];

  void _fetch() async {
    final city = _cityController.text.trim();
    if (city.isEmpty) return;
    // Static sample trends
    final List<_Trend> data = [
      _Trend(month: 'Jan', price: 7200),
      _Trend(month: 'Feb', price: 7250),
      _Trend(month: 'Mar', price: 7350),
      _Trend(month: 'Apr', price: 7400),
      _Trend(month: 'May', price: 7480),
      _Trend(month: 'Jun', price: 7550),
    ];
    setState(() => _trends = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rates & Trends')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(labelText: 'City / Locality'),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(width: 120, child: ElevatedButton(onPressed: _fetch, child: const Text('Show'))),
              ],
            ),
            const SizedBox(height: 16),
            if (_trends.isNotEmpty) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LayoutBuilder(builder: (context, constraints) {
                    final avg = _trends.map((e) => e.price).reduce((a, b) => a + b) / _trends.length;
                    final change = ((_trends.last.price - _trends.first.price) / _trends.first.price) * 100;
                    final isWide = constraints.maxWidth > 600;
                    final tiles = [
                      Expanded(child: MetricTile(title: 'Avg Price', value: _formatCurrency(avg))),
                      const SizedBox(width: 16),
                      Expanded(child: MetricTile(title: '6m Change', value: '${change.toStringAsFixed(1)}%')),
                      const SizedBox(width: 16),
                      Expanded(child: MetricTile(title: 'Latest', value: _formatCurrency(_trends.last.price))),
                    ];
                    return isWide ? Row(children: tiles) : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      MetricTile(title: 'Avg Price', value: _formatCurrency(avg)),
                      const SizedBox(height: 12),
                      MetricTile(title: '6m Change', value: '${change.toStringAsFixed(1)}%'),
                      const SizedBox(height: 12),
                      MetricTile(title: 'Latest', value: _formatCurrency(_trends.last.price)),
                    ]);
                  }),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 160,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        for (final t in _trends)
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(height: (t.price - _trends.first.price + 50) / 2, color: Colors.blue.shade300),
                                const SizedBox(height: 6),
                                Text(t.month),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text('Sample Scenarios', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _scenarioButton('Bengaluru'),
                  _scenarioButton('Mumbai'),
                  _scenarioButton('Hyderabad'),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Trend {
  final String month;
  final double price;
  const _Trend({required this.month, required this.price});
}

String _formatCurrency(double v) => '₹' + v.toStringAsFixed(0).replaceAllMapped(RegExp(r"\\B(?=(\\d{3})+(?!\\d))"), (m) => ',');

Widget _scenarioButton(String city) {
  return OutlinedButton(onPressed: () {}, child: Text(city));
}

