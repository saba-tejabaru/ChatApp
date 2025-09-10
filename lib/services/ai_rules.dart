class AIRules {
  static String respond(String rawInput) {
    final input = rawInput.trim();
    if (input.isEmpty) return '';
    final lower = input.toLowerCase();

    // Greetings
    if (_any(lower, ['hi', 'hello', 'hey'])) {
      return 'Hello! Are you looking to buy, rent, or sell? Share city and budget.';
    }

    // EMI / loan
    if (_any(lower, ['emi', 'loan', 'interest'])) {
      return 'You can estimate EMIs in Tools > Home Loan & EMI. Typical rates ~8–9% p.a. Want me to open it?';
    }

    // BHK queries
    if (_any(lower, ['1 bhk', '2 bhk', '3 bhk', '1bhk', '2bhk', '3bhk'])) {
      return 'For ${_extractBhk(lower)} BHK, share city and budget. I can suggest areas and price bands.';
    }

    // Rent queries with area
    if (lower.contains('rent')) {
      final area = _extractArea(lower);
      if (area != null) {
        return '$area rents for 2 BHK are typically ~₹28k–₹42k/month depending on block and furnishing.';
      }
      return 'Which city/area and BHK are you renting? I can share typical rent ranges.';
    }

    // Buying intent
    if (_any(lower, ['buy', 'purchase'])) {
      return 'Great! What city, preferred locality, BHK, and budget? I can suggest micro-markets and trends.';
    }

    // Selling intent
    if (_any(lower, ['sell', 'listing', 'post property'])) {
      return 'To sell, use Post Property Free. Verified photos and correct pricing help close faster. Want the flow?';
    }

    // Trends / price
    if (_any(lower, ['trend', 'price', 'rates'])) {
      return 'Check Tools > Rates & Trends for micro‑market price charts. Which city/locality should I check?';
    }

    // Default
    return 'Got it. Please share city, locality, budget, and BHK. I can guide prices, areas, and EMIs.';
  }

  static bool _any(String text, List<String> needles) {
    for (final n in needles) {
      if (text.contains(n)) return true;
    }
    return false;
  }

  static String _extractBhk(String text) {
    if (text.contains('1 bhk') || text.contains('1bhk')) return '1';
    if (text.contains('2 bhk') || text.contains('2bhk')) return '2';
    if (text.contains('3 bhk') || text.contains('3bhk')) return '3';
    return '';
  }

  static String? _extractArea(String text) {
    // Very simple area extraction for demo; extend as needed
    final known = ['hsr', 'hsr layout', 'whitefield', 'powai', 'andheri'];
    for (final k in known) {
      if (text.contains(k)) return _title(k);
    }
    return null;
  }

  static String _title(String s) {
    return s.split(' ').map((w) => w.isEmpty ? w : w[0].toUpperCase() + w.substring(1)).join(' ');
  }
}

