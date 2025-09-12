import 'package:flutter/material.dart';
import '../../models/property_item.dart';
import '../../services/realbeez_data_service.dart';
import '../../widgets/realbeez/property_card.dart';

class ListingsListScreen extends StatelessWidget {
  final String title;
  final List<PropertyItem> items;
  const ListingsListScreen({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) => PropertyCard(item: items[index]),
      ),
    );
  }
}

