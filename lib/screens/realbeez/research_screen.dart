import 'package:flutter/material.dart';

class ResearchScreen extends StatelessWidget {
  const ResearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Research')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(title: Text('City Price Index Q2 2025'), subtitle: Text('Price movement across top 8 cities')),
          Divider(),
          ListTile(title: Text('Rental Yield Dashboard'), subtitle: Text('Where rental yields are rising')),
          Divider(),
          ListTile(title: Text('New Launch Monitor'), subtitle: Text('Supply trends by micro-market')),
        ],
      ),
    );
  }
}

