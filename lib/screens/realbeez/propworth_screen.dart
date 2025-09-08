import 'package:flutter/material.dart';

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

  void _estimateWorth() {
    final double area = double.tryParse(_areaController.text) ?? 0;
    if (area <= 0 || _locationController.text.isEmpty) {
      setState(() => _estimate = null);
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
    setState(() => _estimate = area * rate);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estimated Property Value', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(_formatCurrency(_estimate!), style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Text('Note: Indicative estimate based on simplified assumptions.'),
                    ],
                  ),
                ),
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

