import 'package:flutter/material.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = List.generate(6, (i) => _Post(title: 'Market Update ${i + 1}', excerpt: 'Insights on current real estate trends...'));
    return Scaffold(
      appBar: AppBar(title: const Text('Blogs')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final p = posts[index];
          return Card(
            child: ListTile(
              title: Text(p.title),
              subtitle: Text(p.excerpt),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: posts.length,
      ),
    );
  }
}

class _Post {
  final String title;
  final String excerpt;
  _Post({required this.title, required this.excerpt});
}

