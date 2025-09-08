import 'package:flutter/material.dart';
import 'package:real_beez/models/realbeez_sample.dart';
import 'screens/realbeez/home_screen.dart';
import 'screens/realbeez/emi_calculator_screen.dart';
import 'screens/realbeez/placeholder_screens.dart';
import 'screens/realbeez/interior_estimator_screen.dart';
import 'screens/realbeez/propworth_screen.dart';
import 'screens/realbeez/rates_trends_screen.dart';
import 'screens/realbeez/investment_hotspots_screen.dart';
import 'screens/realbeez/help_center_screen.dart';
import 'screens/realbeez/blogs_screen.dart';
import 'screens/realbeez/research_screen.dart';
import 'screens/realbeez/legal_screen.dart';
import 'screens/realbeez/listings_list_screen.dart';
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
        '/prop_valuation': (_) => const PropWorthScreen(),
        '/interior_estimator': (_) => const InteriorEstimatorScreen(),
        '/rates_trends': (_) => const RatesTrendsScreen(),
        '/investment_hotspots': (_) => const InvestmentHotspotsScreen(),
        '/interiors': (_) => const PlaceholderPage(title: 'Home Interiors', description: 'Design to delivery with curated partners.'),
        '/tenant_finder': (_) => const PlaceholderPage(title: 'Relocation + Tenant Finder', description: 'Relocation assistance and tenant matchmaking.'),
        '/utilities': (_) => const PlaceholderPage(title: 'Utilities & Rent Payment', description: 'Pay rent and utilities seamlessly.'),
        '/help_center': (_) => const HelpCenterScreen(),
        '/blogs': (_) => const BlogsScreen(),
        '/research': (_) => const ResearchScreen(),
        '/legal': (_) => const LegalScreen(),
        '/owner_listings': (_) => ListingsListScreen(title: 'Owner Listings', items: RealBeezSamples.ownerListings),
        '/new_projects': (_) => ListingsListScreen(title: 'New Projects', items: RealBeezSamples.newProjects),
      },
    );
  }
}
