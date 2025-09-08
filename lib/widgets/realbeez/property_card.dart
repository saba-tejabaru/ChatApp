import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../models/realbeez_sample.dart';
import '../../theme/realbeez_theme.dart';

class PropertyCard extends StatelessWidget {
  final PropertyItem item;
  const PropertyCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: item.imageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.verified, color: Colors.white, size: 16),
                        const SizedBox(width: 6),
                        Text(item.badge, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: Theme.of(context).textTheme.titleLarge, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: RealBeezTheme.textSecondary),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          item.location,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(item.price, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: RealBeezTheme.accent)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(onPressed: () {}, child: const Text('View Details')),
                      const SizedBox(width: 8),
                      OutlinedButton(onPressed: () {}, child: const Text('Save')),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

