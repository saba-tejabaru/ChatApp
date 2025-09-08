import 'package:flutter/material.dart';

class InteriorEstimatorScreen extends StatefulWidget {
  const InteriorEstimatorScreen({super.key});

  @override
  State<InteriorEstimatorScreen> createState() => _InteriorEstimatorScreenState();
}

class _InteriorEstimatorScreenState extends State<InteriorEstimatorScreen> {
  final TextEditingController _areaController = TextEditingController(text: '1000');
  String _finish = 'Basic';
  int _numBedrooms = 2;
  int _numBathrooms = 2;
  double? _estimate;

  void _calculate() {
    final double area = double.tryParse(_areaController.text) ?? 0;
    if (area <= 0) {
      setState(() => _estimate = null);
      return;
    }
    final Map<String, double> rateMap = {
      'Basic': 1200,
      'Premium': 1800,
      'Luxury': 2500,
    };
    double baseRate = rateMap[_finish] ?? 1200;
    double roomFactor = 1 + ((_numBedrooms - 2) * 0.05) + ((_numBathrooms - 2) * 0.03);
    final double estimate = area * baseRate * roomFactor;
    setState(() => _estimate = estimate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interior Estimator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _areaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Area (sqft)'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _finish,
                    items: const [
                      DropdownMenuItem(value: 'Basic', child: Text('Basic')),
                      DropdownMenuItem(value: 'Premium', child: Text('Premium')),
                      DropdownMenuItem(value: 'Luxury', child: Text('Luxury')),
                    ],
                    onChanged: (v) => setState(() => _finish = v ?? 'Basic'),
                    decoration: const InputDecoration(labelText: 'Finish Level'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _numBedrooms,
                    items: List.generate(5, (i) => i + 1)
                        .map((v) => DropdownMenuItem(value: v, child: Text('$v Bedrooms')))
                        .toList(),
                    onChanged: (v) => setState(() => _numBedrooms = v ?? 2),
                    decoration: const InputDecoration(labelText: 'Bedrooms'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: _numBathrooms,
                    items: List.generate(5, (i) => i + 1)
                        .map((v) => DropdownMenuItem(value: v, child: Text('$v Bathrooms')))
                        .toList(),
                    onChanged: (v) => setState(() => _numBathrooms = v ?? 2),
                    decoration: const InputDecoration(labelText: 'Bathrooms'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 160,
              child: ElevatedButton(onPressed: _calculate, child: const Text('Estimate')),
            ),
            const SizedBox(height: 16),
            if (_estimate != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estimated Cost', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text(_formatCurrency(_estimate!), style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 12),
                      Text('Note: This is an approximate estimate. Actual cost varies by materials and scope.'),
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

