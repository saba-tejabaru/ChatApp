import 'package:flutter/material.dart';
import '../../services/auth_store.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        children: [
          ValueListenableBuilder<AuthUser?>(
            valueListenable: AuthStore.instance.currentUser,
            builder: (context, user, _) {
              final bool signedIn = user != null;
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(radius: 28, child: Text(signedIn ? user!.name.substring(0, 1).toUpperCase() : 'RB')),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(signedIn ? user!.name : 'Guest User', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 4),
                          Text(signedIn ? user!.phone : 'Sign in for a faster 45‑min match', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                    if (!signedIn)
                      const SizedBox.shrink()
                    else
                      TextButton(onPressed: () => AuthStore.instance.signOut(), child: const Text('Sign out')),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          _SectionHeader('My Activity'),
          _Tile(icon: Icons.bookmark_outline, title: 'Saved Properties'),
          _Tile(icon: Icons.history, title: 'Recent Searches'),
          _Tile(icon: Icons.notifications_outlined, title: 'Alerts & Notifications'),

          const SizedBox(height: 8),
          _SectionHeader('Property Management'),
          _Tile(icon: Icons.sell_outlined, title: 'Post Property Free'),
          _Tile(icon: Icons.article_outlined, title: 'Rent Agreement / Legal'),
          _Tile(icon: Icons.home_repair_service_outlined, title: 'Home Services'),

          const SizedBox(height: 8),
          _SectionHeader('Payments & Support'),
          _Tile(icon: Icons.account_balance_wallet_outlined, title: 'Pay Rent & Utilities'),
          _Tile(icon: Icons.support_agent_outlined, title: 'Help Center'),

          const SizedBox(height: 8),
          _SectionHeader('Settings'),
          _Tile(icon: Icons.translate_outlined, title: 'Language'),
          _Tile(icon: Icons.location_on_outlined, title: 'Preferred City'),
          ValueListenableBuilder<AuthUser?>(
            valueListenable: AuthStore.instance.currentUser,
            builder: (context, user, _) {
              if (user == null) return const SizedBox.shrink();
              return _Tile(icon: Icons.logout, title: 'Sign out', onTap: () => AuthStore.instance.signOut());
            },
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(title, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  const _Tile({required this.icon, required this.title, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}