import 'package:flutter/material.dart';
import '../../widgets/common/metric_tile.dart';

class PropWorthScreen extends StatefulWidget {
  const PropWorthScreen({super.key});

  @override
  State<PropWorthScreen> createState() => _PropWorthScreenState();
}

class _PropWorthScreenState extends State<PropWorthScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _areaController = TextEditingController(text: '1000');
  String _propertyType = 'Apartment';
  double? _estimate;
  double? _ratePerSqft;

  void _estimateWorth() {
    final double area = double.tryParse(_areaController.text) ?? 0;
    if (area <= 0 || _locationController.text.isEmpty) {
      setState(() {
        _estimate = null;
        _ratePerSqft = null;
      });
      return;
    }
    final Map<String, double> baseRate = {
      'Apartment': 7000,
      'Villa': 10000,
      'Plot': 5000,
    };
    double rate = baseRate[_propertyType] ?? 7000;
    // crude city factor
    if (_locationController.text.toLowerCase().contains('mumbai')) rate *= 1.6;
    if (_locationController.text.toLowerCase().contains('bengaluru')) rate *= 1.2;
    if (_locationController.text.toLowerCase().contains('hyderabad')) rate *= 1.1;
    setState(() {
      _estimate = area * rate;
      _ratePerSqft = rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PropWorth Valuation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'City / Locality'),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _propertyType,
                    items: const [
                      DropdownMenuItem(value: 'Apartment', child: Text('Apartment')),
                      DropdownMenuItem(value: 'Villa', child: Text('Villa')),
                      DropdownMenuItem(value: 'Plot', child: Text('Plot')),
                    ],
                    onChanged: (v) => setState(() => _propertyType = v ?? 'Apartment'),
                    decoration: const InputDecoration(labelText: 'Property Type'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _areaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Area (sqft)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(width: 160, child: ElevatedButton(onPressed: _estimateWorth, child: const Text('Estimate'))),
            const SizedBox(height: 16),
            if (_estimate != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LayoutBuilder(builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 600;
                    final tiles = [
                      Expanded(child: MetricTile(title: 'Est. Value', value: _formatCurrency(_estimate!))),
                      const SizedBox(width: 16),
                      Expanded(child: MetricTile(title: 'Rate (₹/sqft)', value: _formatCurrency(_ratePerSqft!))),
                      const SizedBox(width: 16),
                      Expanded(child: MetricTile(title: 'Area (sqft)', value: _areaController.text)),
                    ];
                    return isWide
                        ? Row(children: tiles)
                        : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            MetricTile(title: 'Est. Value', value: _formatCurrency(_estimate!)),
                            const SizedBox(height: 12),
                            MetricTile(title: 'Rate (₹/sqft)', value: _formatCurrency(_ratePerSqft!)),
                            const SizedBox(height: 12),
                            MetricTile(title: 'Area (sqft)', value: _areaController.text),
                          ]);
                  }),
                ),
              ),
            const SizedBox(height: 24),
            Text('Sample Scenarios', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                OutlinedButton(onPressed: () { setState(() { _propertyType = 'Apartment'; _locationController.text = 'Bengaluru'; _areaController.text = '1000'; }); _estimateWorth(); }, child: const Text('1,000 sqft Apt, BLR')),
                OutlinedButton(onPressed: () { setState(() { _propertyType = 'Apartment'; _locationController.text = 'Mumbai'; _areaController.text = '800'; }); _estimateWorth(); }, child: const Text('800 sqft Apt, Mumbai')),
                OutlinedButton(onPressed: () { setState(() { _propertyType = 'Villa'; _locationController.text = 'Pune'; _areaController.text = '1200'; }); _estimateWorth(); }, child: const Text('1200 sqft Villa, Pune')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatCurrency(double value) {
    return '₹' + value.toStringAsFixed(0).replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',');
  }
}

Widget _scenarioButton(String label, String type, String city, double area) {
  return OutlinedButton(
    onPressed: () {
      // This function cannot access state here; left as placeholder for consistency.
    },
    child: Text(label),
  );
}

