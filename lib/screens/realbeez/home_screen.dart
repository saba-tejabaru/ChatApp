import 'package:badges/badges.dart' as badges;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/realbeez_sample.dart';
import '../../theme/realbeez_theme.dart';
import '../../widgets/realbeez/property_card.dart';
import '../../widgets/realbeez/quick_tile.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/responsive_grid.dart';
import '../../widgets/common/banner_carousel.dart';

class RealBeezHomeScreen extends StatefulWidget {
  const RealBeezHomeScreen({super.key});

  @override
  State<RealBeezHomeScreen> createState() => _RealBeezHomeScreenState();
}

class _RealBeezHomeScreenState extends State<RealBeezHomeScreen> {
  final List<String> _modes = const ['Buy', 'Rent', 'Sell', 'New Projects'];
  int _selectedModeIndex = 0;
  String _selectedCity = 'Bengaluru';
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            badges.Badge(
              position: badges.BadgePosition.topEnd(top: -2, end: -4),
              badgeContent: const SizedBox(),
              showBadge: true,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: RealBeezTheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('RB', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text('Real Beez'),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 900;
          final EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: isWide ? 32 : 16, vertical: 16);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(padding: pagePadding, child: _buildSpotlightCarousel()),
                const SizedBox(height: 16),
                Padding(
                  padding: pagePadding,
                  child: _buildHeroSection(isWide),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: pagePadding,
                  child: _buildQuickAccess(isWide),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: pagePadding,
                  child: _buildListingsSection(
                    title: 'Listings',
                    items: [
                      ...RealBeezSamples.ownerListings,
                      ...RealBeezSamples.verifiedListings,
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: pagePadding,
                  child: _buildListingsSection(title: 'New Projects', items: RealBeezSamples.newProjects),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: pagePadding,
                  child: _buildToolsHub(isWide),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: pagePadding,
                  child: _buildLocalityInsights(isWide),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: pagePadding,
                  child: _buildPersonalActivity(isWide),
                ),
                const SizedBox(height: 24),
                _buildFooter(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(bool isWide) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFFF7E6), Color(0xFFEFF6FF)]),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('One Platform for Buy, Rent, Sell, Finance, Interiors & More.', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 8),
          Text(
            'Discover verified properties, calculate EMIs, get interiors, and manage everything end-to-end.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          _buildSearchBar(isWide),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isWide) {
    final chips = Row(
      children: List.generate(_modes.length, (index) {
        final bool selected = index == _selectedModeIndex;
        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ChoiceChip(
            label: Text(_modes[index]),
            selected: selected,
            onSelected: (_) => setState(() => _selectedModeIndex = index),
          ),
        );
      }),
    );

    final line = Row(
      children: [
        chips,
        const SizedBox(width: 12),
        SizedBox(
          width: isWide ? 240 : 180,
          child: DropdownButtonFormField<String>(
            value: _selectedCity,
            items: const [
              DropdownMenuItem(value: 'Bengaluru', child: Text('Bengaluru')),
              DropdownMenuItem(value: 'Mumbai', child: Text('Mumbai')),
              DropdownMenuItem(value: 'Delhi', child: Text('Delhi')),
              DropdownMenuItem(value: 'Pune', child: Text('Pune')),
              DropdownMenuItem(value: 'Hyderabad', child: Text('Hyderabad')),
            ],
            onChanged: (v) => setState(() => _selectedCity = v ?? _selectedCity),
            decoration: const InputDecoration(prefixIcon: Icon(Icons.location_on_outlined), labelText: 'City'),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Search locality or project',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(onPressed: () => _searchController.clear(), icon: const Icon(Icons.clear)),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 140,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Search'),
          ),
        ),
      ],
    );

    return isWide
        ? line
        : SingleChildScrollView(scrollDirection: Axis.horizontal, child: ConstrainedBox(constraints: const BoxConstraints(minWidth: 800), child: line));
  }

  Widget _buildSpotlightCarousel() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Spotlight'),
          const SizedBox(height: 12),
          BannerCarousel(
            imageUrls: RealBeezSamples.spotlightBanners,
            height: 180,
            ctaLabel: 'Get the App',
            onCta: () {},
          ),
        ],
      );

  Widget _buildQuickAccess(bool isWide) {
    final tiles = [
      QuickServiceTile(
        icon: Icons.add_home_work_rounded,
        title: 'Post Property Free',
        subtitle: 'List your property in minutes',
        onTap: () => Navigator.pushNamed(context, '/post_property'),
      ),
      QuickServiceTile(
        icon: Icons.calculate_rounded,
        title: 'Home Loan & EMI',
        subtitle: 'Plan your budget smartly',
        onTap: () => Navigator.pushNamed(context, '/emi_calculator'),
      ),
      QuickServiceTile(
        icon: Icons.article_outlined,
        title: 'Rent Agreement',
        subtitle: 'Legal docs made easy',
        onTap: () => Navigator.pushNamed(context, '/rent_agreement'),
      ),
      QuickServiceTile(
        icon: Icons.home_repair_service_outlined,
        title: 'Home Services',
        subtitle: 'Packers, repairs, cleaning',
        onTap: () => Navigator.pushNamed(context, '/home_services'),
      ),
      QuickServiceTile(
        icon: Icons.trending_up_rounded,
        title: 'PropWorth & Trends',
        subtitle: 'Valuation & rates',
        onTap: () => Navigator.pushNamed(context, '/prop_valuation'),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Quick Access'),
        const SizedBox(height: 12),
        ResponsiveGridBuilder(
          wideCrossAxisCount: 3,
          narrowCrossAxisCount: 1,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: isWide ? 3.2 : 3.6,
          itemCount: tiles.length,
          itemBuilder: (context, index) => tiles[index],
        ),
      ],
    );
  }

  Widget _buildListingsSection({required String title, required List<PropertyItem> items}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, trailing: TextButton(onPressed: () {}, child: const Text('See all'))),
        const SizedBox(height: 12),
        LayoutBuilder(builder: (context, c) {
          final isNarrow = c.maxWidth < 700;
          if (isNarrow) {
            return ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) => PropertyCard(item: items[index]),
            );
          }
          return SizedBox(
            height: 320,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) => PropertyCard(item: items[index]),
            ),
          );
        }),
      ],
    );
  }

  // removed combined listings and carousel variant per user request

  Widget _buildToolsHub(bool isWide) {
    final List<_ToolItem> tools = [
      _ToolItem('EMI Calculator', Icons.calculate_rounded, '/emi_calculator'),
      _ToolItem('Interior Estimator', Icons.weekend_outlined, '/interior_estimator'),
      _ToolItem('PropWorth', Icons.price_change_outlined, '/prop_valuation'),
      _ToolItem('Rates & Trends', Icons.show_chart_rounded, '/rates_trends'),
      _ToolItem('Investment Hotspots', Icons.local_fire_department_outlined, '/investment_hotspots'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Tools Hub'),
        const SizedBox(height: 12),
        ResponsiveGridBuilder(
          wideCrossAxisCount: 6,
          narrowCrossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.4,
          itemCount: tools.length,
          itemBuilder: (context, index) {
            final t = tools[index];
            return InkWell(
              onTap: () => Navigator.pushNamed(context, t.route),
              borderRadius: BorderRadius.circular(16),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(t.icon, size: 22, color: RealBeezTheme.accent),
                    const SizedBox(height: 6),
                    Text(t.label, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLocalityInsights(bool isWide) {
    final insights = [
      _InsightItem(
        title: 'HSR Layout: Connectivity & Livability',
        thumbnail: 'https://img.youtube.com/vi/3fumBcKC6RE/hqdefault.jpg',
        description: 'Parks, cafes, startup scene and metro plans make it hot.',
      ),
      _InsightItem(
        title: 'Powai: Lakefront living & work hubs',
        thumbnail: 'https://img.youtube.com/vi/oHg5SJYRHA0/hqdefault.jpg',
        description: 'Green pockets, malls, and quick access to Eastern Freeway.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Locality Reviews & Insights'),
        const SizedBox(height: 12),
        CarouselSlider.builder(
          itemCount: insights.length,
          itemBuilder: (context, index, real) {
            final i = insights[index];
            return Card(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                    child: Stack(
                      children: [
                        Image.network(i.thumbnail, width: isWide ? 220 : 140, height: isWide ? double.infinity : 160, fit: BoxFit.cover),
                        const Positioned.fill(child: Center(child: Icon(Icons.play_circle_fill_rounded, size: 48, color: Colors.white))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(i.title, style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 8),
                          Text(i.description, style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            children: const [
                              Chip(label: Text('Schools')),
                              Chip(label: Text('Hospitals')),
                              Chip(label: Text('Parks')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: isWide ? 220 : 200,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalActivity(bool isWide) {
    Widget activityCard(String title, String subtitle, IconData icon, VoidCallback onTap) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(color: Colors.blue.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                child: Icon(icon, color: Colors.blue),
              ),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 4), Text(subtitle, style: Theme.of(context).textTheme.bodyMedium)])),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      );
    }

    Widget servicePromo(String title, String subtitle, IconData icon, VoidCallback onTap, {List<String> tags = const []}) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFFFF7E6), Color(0xFFEFF6FF)]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(color: Colors.orange.withOpacity(0.18), borderRadius: BorderRadius.circular(12)),
                    child: Icon(icon, color: Colors.orange),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(title, style: Theme.of(context).textTheme.titleLarge)),
                ],
              ),
              const SizedBox(height: 8),
              Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              Wrap(spacing: 8, runSpacing: 6, children: tags.map((t) => Chip(label: Text(t))).toList()),
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerLeft, child: ElevatedButton(onPressed: onTap, child: const Text('Explore'))),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Your Activity'),
        const SizedBox(height: 12),
        ResponsiveGridBuilder(
          wideCrossAxisCount: 3,
          narrowCrossAxisCount: 1,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: isWide ? 3.2 : 3.6,
          itemCount: 3,
          itemBuilder: (context, index) {
            final items = [
              activityCard('Saved Properties', 'You have 2 saved homes', Icons.bookmark_outline_rounded, () {}),
              activityCard('Recent Searches', 'HSR 2BHK • Powai 1BHK', Icons.history_rounded, () {}),
              activityCard('Notifications', '3 new matches near you', Icons.notifications_outlined, () {}),
            ];
            return items[index];
          },
        ),
        const SizedBox(height: 24),
        const SectionHeader(title: 'Extended Services'),
        const SizedBox(height: 12),
        ResponsiveGridBuilder(
          wideCrossAxisCount: 3,
          narrowCrossAxisCount: 1,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: isWide ? 1.9 : 1.7,
          itemCount: 3,
          itemBuilder: (context, index) {
            final items = [
              servicePromo('Home Interiors', 'Design + execution with curated partners', Icons.chair_outlined, () => Navigator.pushNamed(context, '/interiors'), tags: const ['Modular', 'False ceiling', 'Painting']),
              servicePromo('Relocation & Tenant Finder', 'Hassle-free moving and tenants', Icons.local_shipping_outlined, () => Navigator.pushNamed(context, '/tenant_finder'), tags: const ['Packers', 'Verification', 'Agreements']),
              servicePromo('Utilities & Rent Payment', 'Pay rent and utilities in-app', Icons.account_balance_wallet_outlined, () => Navigator.pushNamed(context, '/utilities'), tags: const ['Reminders', 'Receipts']),
            ];
            return items[index];
          },
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _FooterLink('Help Center', onTap: () => Navigator.pushNamed(context, '/help_center')),
              _FooterLink('Blogs', onTap: () => Navigator.pushNamed(context, '/blogs')),
              _FooterLink('Research', onTap: () => Navigator.pushNamed(context, '/research')),
              _FooterLink('Legal', onTap: () => Navigator.pushNamed(context, '/legal')),
              _FooterLink('Owner Listings', onTap: () => Navigator.pushNamed(context, '/owner_listings')),
              _FooterLink('New Projects', onTap: () => Navigator.pushNamed(context, '/new_projects')),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: const [
              _CityLink('Bengaluru'),
              _CityLink('Mumbai'),
              _CityLink('Delhi'),
              _CityLink('Pune'),
              _CityLink('Hyderabad'),
              _CityLink('Chennai'),
            ],
          ),
          const SizedBox(height: 16),
          Text('© 2025 Real Beez. All rights reserved.', style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  // Section header now provided by SectionHeader common widget
}

class _ToolItem {
  final String label;
  final IconData icon;
  final String route;
  _ToolItem(this.label, this.icon, this.route);
}

class _InsightItem {
  final String title;
  final String thumbnail;
  final String description;
  _InsightItem({required this.title, required this.thumbnail, required this.description});
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  const _FooterLink(this.label, {this.onTap});
  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onTap, child: Text(label));
  }
}

class _CityLink extends StatelessWidget {
  final String label;
  const _CityLink(this.label);
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: () {}, child: Text(label));
  }
}

