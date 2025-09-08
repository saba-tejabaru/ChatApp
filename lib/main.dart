import 'package:flutter/material.dart';
import 'screens/realbeez/home_screen.dart';
import 'screens/realbeez/emi_calculator_screen.dart';
import 'screens/realbeez/placeholder_screens.dart';
import 'theme/realbeez_theme.dart';

void main() => runApp(const RealBeezApp());

class RealBeezApp extends StatelessWidget {
  const RealBeezApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Real Beez',
      debugShowCheckedModeBanner: false,
      theme: RealBeezTheme.themeData(),
      routes: {
        '/': (_) => const RealBeezHomeScreen(),
        '/emi_calculator': (_) => const EMICalculatorScreen(),
        '/post_property': (_) => const PlaceholderPage(title: 'Post Property Free', description: 'List your property with photos, details, and reach verified buyers or tenants.'),
        '/rent_agreement': (_) => const PlaceholderPage(title: 'Rent Agreement / Legal Docs', description: 'Get legally vetted rent agreements and other property documents.'),
        '/home_services': (_) => const PlaceholderPage(title: 'Home Services', description: 'Packers & movers, repairs, cleaning, painting and more.'),
        '/prop_valuation': (_) => const PlaceholderPage(title: 'PropWorth Valuation', description: 'Estimate property worth and explore rates & trends.'),
        '/interior_estimator': (_) => const PlaceholderPage(title: 'Interior Estimator', description: 'Plan interiors with ballpark budgets for your home.'),
        '/rates_trends': (_) => const PlaceholderPage(title: 'Rates & Trends', description: 'Track local price trends and market movement.'),
        '/investment_hotspots': (_) => const PlaceholderPage(title: 'Investment Hotspots', description: 'Discover high-growth areas for real estate investing.'),
        '/interiors': (_) => const PlaceholderPage(title: 'Home Interiors', description: 'Design to delivery with curated partners.'),
        '/tenant_finder': (_) => const PlaceholderPage(title: 'Relocation + Tenant Finder', description: 'Relocation assistance and tenant matchmaking.'),
        '/utilities': (_) => const PlaceholderPage(title: 'Utilities & Rent Payment', description: 'Pay rent and utilities seamlessly.'),
      },
    );
  }
}
