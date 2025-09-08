import 'dart:math' as math;
import 'package:flutter/material.dart';

class EMICalculatorScreen extends StatefulWidget {
  const EMICalculatorScreen({super.key});

  @override
  State<EMICalculatorScreen> createState() => _EMICalculatorScreenState();
}

class _EMICalculatorScreenState extends State<EMICalculatorScreen> {
  final TextEditingController _principalController = TextEditingController(text: '5000000');
  final TextEditingController _rateController = TextEditingController(text: '8.0');
  final TextEditingController _tenureYearsController = TextEditingController(text: '20');

  double? _emi;
  double? _totalInterest;
  double? _totalPayment;

  void _calculate() {
    final double principal = double.tryParse(_principalController.text.replaceAll(',', '')) ?? 0;
    final double annualRate = double.tryParse(_rateController.text) ?? 0;
    final double tenureYears = double.tryParse(_tenureYearsController.text) ?? 0;

    if (principal <= 0 || annualRate <= 0 || tenureYears <= 0) {
      setState(() {
        _emi = null;
        _totalInterest = null;
        _totalPayment = null;
      });
      return;
    }

    final double monthlyRate = annualRate / 12 / 100;
    final int months = (tenureYears * 12).round();
    final double pow = math.pow(1 + monthlyRate, months).toDouble();
    final double emi = principal * monthlyRate * pow / (pow - 1);
    final double totalPayment = emi * months;
    final double totalInterest = totalPayment - principal;

    setState(() {
      _emi = emi;
      _totalPayment = totalPayment;
      _totalInterest = totalInterest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Loan & EMI Calculator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _principalController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Principal (₹)'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _rateController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Interest Rate (% p.a.)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tenureYearsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Tenure (years)'),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: _calculate,
                    child: const Text('Calculate'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_emi != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      _MetricTile(title: 'Monthly EMI', value: _formatCurrency(_emi!)),
                      const SizedBox(width: 16),
                      _MetricTile(title: 'Total Interest', value: _formatCurrency(_totalInterest!)),
                      const SizedBox(width: 16),
                      _MetricTile(title: 'Total Payment', value: _formatCurrency(_totalPayment!)),
                    ],
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
                  _scenarioButton('₹50L, 8.0%, 20y', 5000000, 8.0, 20),
                  _scenarioButton('₹75L, 8.5%, 25y', 7500000, 8.5, 25),
                  _scenarioButton('₹1Cr, 9.0%, 30y', 10000000, 9.0, 30),
                ],
              ),
            ] else ...[
              Text('Enter values and tap Calculate to view EMI details.', style: Theme.of(context).textTheme.bodyLarge),
            ],
          ],
        ),
      ),
    );
  }

  Widget _scenarioButton(String label, double p, double r, double y) {
    return OutlinedButton(
      onPressed: () {
        _principalController.text = p.toStringAsFixed(0);
        _rateController.text = r.toStringAsFixed(1);
        _tenureYearsController.text = y.toStringAsFixed(0);
        _calculate();
      },
      child: Text(label),
    );
  }

  String _formatCurrency(double value) {
    // Simple formatting for INR, avoids intl dependency for now
    return '₹' + value.toStringAsFixed(0).replaceAllMapped(RegExp(r"\B(?=(\d{3})+(?!\d))"), (m) => ',');
  }
}

class _MetricTile extends StatelessWidget {
  final String title;
  final String value;
  const _MetricTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 6),
          Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Theme.of(context).colorScheme.secondary)),
        ],
      ),
    );
  }
}

