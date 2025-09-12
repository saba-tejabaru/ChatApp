import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/property_item.dart';

class RealBeezDataService {
  static RealBeezDataService? _instance;
  static RealBeezDataService get instance => _instance ??= RealBeezDataService._();
  
  RealBeezDataService._();
  
  List<PropertyItem>? _ownerListings;
  List<PropertyItem>? _verifiedListings;
  List<PropertyItem>? _newProjects;
  List<String>? _spotlightBanners;
  
  bool _isLoaded = false;
  
  /// Initialize the service by loading data from JSON
  Future<void> initialize() async {
    if (_isLoaded) return;
    
    try {
      final String jsonString = await rootBundle.loadString('realbeez_sample.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      
      // Extract data from the JSON structure
      final classesData = jsonData['classes'] as Map<String, dynamic>;
      final realBeezSamplesData = classesData['RealBeezSamples'] as Map<String, dynamic>;
      final collectionsData = realBeezSamplesData['collections'] as Map<String, dynamic>;
      
      // Parse owner listings
      final ownerListingsData = collectionsData['ownerListings'] as Map<String, dynamic>;
      _ownerListings = _parsePropertyItems(ownerListingsData['items'] as List<dynamic>);
      
      // Parse verified listings
      final verifiedListingsData = collectionsData['verifiedListings'] as Map<String, dynamic>;
      _verifiedListings = _parsePropertyItems(verifiedListingsData['items'] as List<dynamic>);
      
      // Parse new projects
      final newProjectsData = collectionsData['newProjects'] as Map<String, dynamic>;
      _newProjects = _parsePropertyItems(newProjectsData['items'] as List<dynamic>);
      
      // Parse spotlight banners
      final spotlightBannersData = collectionsData['spotlightBanners'] as Map<String, dynamic>;
      _spotlightBanners = List<String>.from(spotlightBannersData['items'] as List<dynamic>);
      
      _isLoaded = true;
    } catch (e) {
      print('Error loading RealBeez data from JSON: $e');
      // Fallback to empty lists if JSON loading fails
      _ownerListings = [];
      _verifiedListings = [];
      _newProjects = [];
      _spotlightBanners = [];
      _isLoaded = true;
    }
  }
  
  /// Parse property items from JSON data
  List<PropertyItem> _parsePropertyItems(List<dynamic> itemsData) {
    return itemsData.map((item) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      return PropertyItem(
        id: itemMap['id'] as String,
        title: itemMap['title'] as String,
        location: itemMap['location'] as String,
        price: itemMap['price'] as String,
        imageUrl: itemMap['imageUrl'] as String,
        badge: itemMap['badge'] as String,
      );
    }).toList();
  }
  
  /// Get owner listings
  List<PropertyItem> get ownerListings {
    if (!_isLoaded) {
      throw Exception('RealBeezDataService not initialized. Call initialize() first.');
    }
    return _ownerListings ?? [];
  }
  
  /// Get verified listings
  List<PropertyItem> get verifiedListings {
    if (!_isLoaded) {
      throw Exception('RealBeezDataService not initialized. Call initialize() first.');
    }
    return _verifiedListings ?? [];
  }
  
  /// Get new projects
  List<PropertyItem> get newProjects {
    if (!_isLoaded) {
      throw Exception('RealBeezDataService not initialized. Call initialize() first.');
    }
    return _newProjects ?? [];
  }
  
  /// Get spotlight banners
  List<String> get spotlightBanners {
    if (!_isLoaded) {
      throw Exception('RealBeezDataService not initialized. Call initialize() first.');
    }
    return _spotlightBanners ?? [];
  }
  
  /// Check if service is loaded
  bool get isLoaded => _isLoaded;
  
  /// Reload data (useful for testing or data updates)
  Future<void> reload() async {
    _isLoaded = false;
    await initialize();
  }
}